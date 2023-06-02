//
//  ContentView.swift
//  voca2
//
//  Created by GANBAT BATORGIL on 2023/04/06.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @ObservedObject var scan = scanTimer()  // scanTimerのインスタンスを作り観測する
    @State var currentScreen = "phrase"
    @State var currentText = ""
    @State var masterVolume: Float = 1.0
    @State var panelnum: Int = 0
    @State var arrnum: Int = 0
   
    @State private var phraseSet1: [String] = ["こんにちは", "お腹がすいた", "こっちに来て", "ありがとう", "はい", "いいえ", "あつい", "さむい", "くるしい", "ベッド", "体", "文字盤", "トイレ", "吸引", "テレビ", "上げて", "下げて", "向きを変えて"]
    @State public var phraseSet6: [String] = ["ZZZZZZ", "AAA", "こっちに来て", "ありがとう", "はい", "いいえ", "あつい", "さむい", "くるしい", "ベッド", "体", "文字盤", "トイレ", "吸引", "テレビ", "上げて", "下げて", "向きを変えて"]
    @State public var phraseSet7: [String] = ["ZAZAZA", "AAA", "こっちに来て", "ありがとう", "はい", "いいえ", "あつい", "さむい", "くるしい", "ベッド", "体", "文字盤", "トイレ", "吸引", "テレビ", "上げて", "下げて", "向きを変えて"]
    @State public var phraseSet8: [String] = ["QQQQQ", "AAA", "こっちに来て", "ありがとう", "はい", "いいえ", "あつい", "さむい", "くるしい", "ベッド", "体", "文字盤", "トイレ", "吸引", "テレビ", "上げて", "下げて", "向きを変えて"]
    @State private var voiceSet1: [String] = ["konnitiwa", "onakasuita", "come", "thanks", "yes", "no", "hot", "cold", "kurusii", "bed", "body", "moziban", "toilet", "kyuuin", "tv", "up", "down", "change"]
    
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
        }
         VStack{
        }//.onAppear{
          //  self.writingToFile_Da(savedata: phraseSet1, savename: "phrarray.dat")
          //  self.writingToFile_Da(savedata: voiceSet1, savename: "vcarray.dat")
       // }
    }
    
       // ファイル書き込み（Data）=============================================================
        func writingToFile_Da(savedata: [String], savename: String) {
            // DocumentsフォルダURL取得
            guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                fatalError("フォルダURL取得エラー")
            }
            // 対象のファイルURL取得
            let fileURL = dirURL.appendingPathComponent(savename)
            // ファイルの書き込み//JSONEncoderを利用
            do {
                let encoder = JSONEncoder()
                let data: Data = try encoder.encode(savedata)
                try data.write(to: fileURL)
            } catch {
                print("Error: \(error)")
            }
        }
        // =================================================================================
    
        // ファイル読み込み（Data）=============================================================
        func readFromFile_Da(savename: String) -> [String] { //[String]を返す仕様に変更
            // DocumentsフォルダURL取得
            guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                fatalError("フォルダURL取得エラー")
            }
            // 対象のファイルURL取得
            let fileURL = dirURL.appendingPathComponent(savename)
            // ファイルの読み込み//JSONDecoderを利用
            do{
                let fileContents = try Data(contentsOf: fileURL)
                let read_strings = try JSONDecoder().decode([String].self, from: fileContents)
                // 読み込んだ内容を戻り値として返す
                return read_strings
            }catch{
                fatalError("ファイル読み込みエラー")
    
            }
        }
        // =================================================================================
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
