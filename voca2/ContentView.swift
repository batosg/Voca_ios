//
//  ContentView.swift
//  voca2
//
//  Created by GANBAT BATORGIL on 2023/04/06.
//
//recording
import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @ObservedObject var scan = scanTimer()  // scanTimerのインスタンスを作り観測する
    @State var currentScreen = "phrase"
    @State var currentText = ""
    @State var masterVolume: Float = 1.0
    @State var panelnum: Int = 0
    @State var arrnum: Int = 0
    //配列の初期値
    @State private var phraseSet1: [String] = ["こんにちは", "お腹がすいた", "こっちに来て", "ありがとう", "はい", "いいえ", "あつい", "さむい", "くるしい", "ベッド", "体", "文字盤", "トイレ", "吸引", "テレビ", "上げて", "下げて", "向きを変えて"]
    @State public var phraseSet6: [String] = ["こっちに来て", "こっちに来て", "こっちに来て", "こっちに来て", "はい", "いいえ", "あつい", "さむい", "くるしい", "ベッド", "体", "文字盤", "トイレ", "吸引", "テレビ", "上げて", "下げて", "向きを変えて"]
    @State public var phraseSet7: [String] = ["お腹がすいた", "お腹がすいた", "お腹がすいた", "お腹がすいた", "はい", "いいえ", "あつい", "さむい", "くるしい", "ベッド", "体", "文字盤", "トイレ", "吸引", "テレビ", "上げて", "下げて", "向きを変えて"]
    @State public var phraseSet8: [String] = ["こんにちは", "こんにちは", "こんにちは", "こんにちは", "はい", "いいえ", "あつい", "さむい", "くるしい", "ベッド", "体", "文字盤", "トイレ", "吸引", "テレビ", "上げて", "下げて", "向きを変えて"]
    // currentScreenに代入された文字列に応じて画面を切り替える
    var body: some View {
        if (currentScreen == "phrase") {
            phraseView(screen: $currentScreen, theText: $currentText, playvol: $masterVolume,panel:$panelnum)
        } else if (currentScreen == "hiragana") {
            hiraganaView(screen: $currentScreen, theText: $currentText, playvol: $masterVolume)
        } else if (currentScreen == "dakuHira") {
            dakuHiraView(screen: $currentScreen, theText: $currentText, playvol: $masterVolume)
        } else if (currentScreen == "katakana") {
            katakanaView(screen: $currentScreen, theText: $currentText, playvol: $masterVolume)
        } else if (currentScreen == "dakuKata") {
            dakuKataView(screen: $currentScreen, theText: $currentText, playvol: $masterVolume)
        } else if (currentScreen == "option") {
            optionView(screen: $currentScreen, theText: $currentText, playvol: $masterVolume,panel:$panelnum,arrnum: $arrnum, phraseSet1:$phraseSet1,phraseSet6:$phraseSet6,phraseSet7:$phraseSet7,phraseSet8:$phraseSet8)
        } else if (currentScreen == "record") {
            recordView(screen: $currentScreen, theText: $currentText, playvol: $masterVolume,panel:$panelnum,arrnum: $arrnum, phraseSet1:$phraseSet1,phraseSet6:$phraseSet6,phraseSet7:$phraseSet7,phraseSet8:$phraseSet8)
        }else if (currentScreen == "Panel1") {
            Panel1(screen: $currentScreen,panel:$panelnum, arrnum: $arrnum, phraseSet1:$phraseSet1,phraseSet6:$phraseSet6,phraseSet7:$phraseSet7,phraseSet8:$phraseSet8)
        }else if (currentScreen == "Panel2") {
            Panel2(screen: $currentScreen,panel:$panelnum, arrnum: $arrnum, phraseSet1:$phraseSet1,phraseSet6:$phraseSet6,phraseSet7:$phraseSet7,phraseSet8:$phraseSet8)
        }else if (currentScreen == "Panel3") {
            Panel3(screen: $currentScreen,panel:$panelnum, arrnum: $arrnum, phraseSet1:$phraseSet1,phraseSet6:$phraseSet6,phraseSet7:$phraseSet7,phraseSet8:$phraseSet8)
        }else if (currentScreen == "logview") {
            LogView(screen:$currentScreen)
        }
        VStack{
        }.onAppear{
            //初期設定、ファイルが存在しているか確認し、なかったい場合作る
            checkAndCreateFile(fileName: "phrarray.dat",initialContent: ["こんにちは", "お腹がすいた", "こっちに来て", "ありがとう", "はい", "いいえ", "あつい", "さむい", "くるしい", "ベッド", "体", "文字盤", "トイレ", "吸引", "テレビ", "上げて", "下げて", "向きを変えて"])
            checkAndCreateFile(fileName: "ps0.dat",initialContent: ["こんにちは", "お腹がすいた", "こっちに来て", "ありがとう", "はい", "いいえ", "あつい", "さむい", "くるしい", "ベッド", "体", "文字盤", "トイレ", "吸引", "テレビ", "上げて", "下げて", "向きを変えて"])
            checkAndCreateFile(fileName: "ps1.dat",initialContent: ["ペン", "ノート", "はさみ", "けしゴム", "えんぴつ", "シャープペンシル", "ホチキス", "リボン", "マーカー", "クリアファイル", "のり", "カッター", "シート", "テープ", "シール", "クレヨン", "ボールペン", "シャープナー"])
            checkAndCreateFile(fileName: "ps2.dat",initialContent: ["いぬ", "ねこ", "とり", "さかな", "とら", "おおかみ", "さる", "ぞう", "ひつじ", "うし", "うま", "うさぎ", "くま", "へび", "かめ", "きつね", "しか", "ちょう"])
            checkAndCreateFile(fileName: "ps3.dat",initialContent: ["にほん", "アメリカ", "カナダ", "イギリス", "フランス", "ドイツ", "ロシア", "ブラジル", "オーストラリア", "中国", "韓国", "インド", "スペイン", "イタリア", "メキシコ", "インドネシア", "トルコ", "南アフリカ"])
            checkAndCreateFile(fileName: "logdata.txt",initialContent:[])
        }
    }
    
    //ファイルを存在しているか確認し、なかったい場合には作成する
    func checkAndCreateFile(fileName: String, initialContent: [String]) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Unable to access document directory")
            return
        }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            let content = "[\"" + initialContent.joined(separator: "\", \"") + "\"]"
            
            do {
                try content.write(to: fileURL, atomically: true, encoding: .utf8)
                print("File:\(fileName) created successfully")
            } catch {
                print("Error creating file:\(fileName) \(error)")
            }
        } else {
            print("\(fileName) already exists")
        }
    }
    
    // =================================================================================
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

