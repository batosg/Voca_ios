//
//  Option.swift
//  voca2
//
//  Created by GANBAT BATORGIL on 2023/04/06.
//

import Foundation
import SwiftUI
import AVFoundation
import UIKit

// 設定画面
//Panel 0
struct optionView: View {
    // ContentViewの変数をバインディングする
    @Binding var screen: String
    @Binding var theText: String
    @Binding var playvol: Float
    @Binding var panel: Int
    @Binding var arrnum: Int
    @Binding var phraseSet1: [String]
    @Binding var phraseSet6: [String]
    @Binding var phraseSet7: [String]
    @Binding var phraseSet8: [String]
    
    @State private var isShowingDialog = false
    @State private var showingAlert = false
    
    // scanTimerのインスタンスを作り観測する
    @ObservedObject var scan = scanTimer()
    var body: some View {
        
        ZStack {
            Color(red: 191/255, green: 228/255, blue: 255/255).ignoresSafeArea()
            let resultColor = colortextOrAudio(phraseSet: phraseSet1, arrnum: 0, defaultColor: .white)
            HStack {
                
                VStack {
                    HStack{
                        
                        ForEach(0..<4) { index in
                            Button(action: {
                                if(index==1){
                                    screen="Panel1"
                                }else if (index==2){
                                    screen="Panel2"
                                }else if (index==3){
                                    screen="Panel3"
                                }else if (index==0){
                                    screen="option"
                                }
                            }) {
                                Text(" パネル"+" \(index+1)")
                                    .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                                    .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                    .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.height * 0.075)
                                    .background(index==0 ? Color.blue:Color.white)          //選択されたパネルの色が青になる
                                    .border(Color.black)
                                
                            }
                        }
                    }
                    Spacer().frame(height:200)
                    HStack{
                        VStack{
                            Button(action: {
                                print("スペース")
                            }) {
                                Text(" ")
                                    .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                                    .foregroundColor(Color.white)
                                    .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.height * 0.075)                 .background(Color(red: 191/255, green: 228/255, blue: 255/255))
                            }
                            ForEach(0..<4) { index in
                                Button(action: {
                                    print("\(phraseSet1[index]) ")
                                    panel=0
                                    screen="record"
                                    arrnum=index
                                }) {
                                    if(index < phraseSet1.count){
                                        Text("\(phraseSet1[index]) ")
                                            .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                                            .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                            .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.height * 0.075)
                                            .background(Color(resultColor))
                                            .border(Color.black)
                                    }
                                }
                            }
                        }
                        VStack{
                            ForEach(4..<9) { index in
                                Button(action: {
                                    print("\(phraseSet1[index]) ")
                                    panel=0
                                    screen="record"
                                    arrnum=index
                                }) {
                                    if(index < phraseSet1.count){
                                        Text("\(phraseSet1[index]) ")
                                            .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                                            .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                            .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.height * 0.075)
                                            .background(Color.white)
                                            .border(Color.black)
                                    }
                                }
                            }
                        }
                        VStack{
                            ForEach(9..<14) { index in
                                Button(action: {
                                    print("\(phraseSet1[index]) ")
                                    panel=0
                                    screen="record"
                                    arrnum=index
                                }) {
                                    if(index < phraseSet1.count){
                                        Text("\(phraseSet1[index]) ")
                                            .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                                            .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                            .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.height * 0.075)
                                            .background(Color.white)
                                            .border(Color.black)
                                    }
                                }
                            }
                        }
                        VStack{
                            ForEach(14..<18) { index in
                                Button(action: {
                                    print("\(phraseSet1[index]) ")
                                    panel=0
                                    screen="record"
                                    arrnum=index
                                    
                                }) {
                                    if(index < phraseSet1.count){
                                        Text("\(phraseSet1[index]) ")
                                            .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                                            .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                            .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.height * 0.075)
                                            .background(Color.white)
                                            .border(Color.black)
                                    }
                                }
                            }
                            Button(action: {
                                print("スペース")
                            }) {
                                Text(" ")
                                    .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                                    .foregroundColor(Color.white)
                                    .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.height * 0.075)                 .background(Color(red: 191/255, green: 228/255, blue: 255/255))
                            }
                        }
                    }
                }
                VStack{
                    
                    Button(action: {
                        screen="logview"
                        
                    }) {
                        Text("ログ")
                            .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                            .foregroundColor(Color(red: 0, green:65/255, blue: 255/255))
                            .frame(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.height * 0.075)
                            .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                            .border(Color.black)
                    }
                    
                    // 設定を初期化するボタン
                    Button(action: {
                        
                        print(resultColor)
                        
                    }) {
                        Text("データ")
                            .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                            .foregroundColor(Color(red: 0, green:65/255, blue: 255/255))
                            .frame(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.height * 0.075)
                            .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                            .border(Color.black)
                    }
                    Button(action: {
                        print("初期化")
                        isShowingDialog=true

                    }) {
                        Label("初期化", systemImage: "trash")
                            .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                            .foregroundColor(Color.white)
                            .frame(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.height * 0.075)
                            .background(Color(red: 255/255, green: 75/255, blue: 0))
                            .border(Color.black)
                    }.confirmationDialog("注意！",isPresented: $isShowingDialog) {
                        Button("削除する",role:.destructive){
                            ResetAllFiles()
                            showingAlert=true

                        }.alert(isPresented: $showingAlert) {
                            //Alert message
                            Alert(
                                title: Text("メッセージ"),
                                message: Text("初期化れました"),
                                dismissButton: .default(Text("OK"),action: {}))
                        }
                        Button("キャンセル",role:.cancel){
                            print("cancel")
                        }
                    }message: {
                        Text("全てのデータが初期化されるので戻せません")
                    }
                    
                    .buttonStyle(BorderlessButtonStyle())

                    // 定型句画面に戻るボタン
                    Button(action: {
                        screen = "phrase"
                        panel=0
                        let sourceURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("ps0.dat")
                        let destinationURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("phrarray.dat")
                        self.writingToFile_Da(savedata: phraseSet1, savename: "ps0.dat")
                        
                        overwriteFile(from: sourceURL, to: destinationURL)
                        
                    }) {
                        Text("戻る")
                            .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                            .foregroundColor(Color(red: 0, green:65/255, blue: 255/255))
                            .frame(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.height * 0.075)
                            .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                            .border(Color.black)
                    }
                }
            }
        }.onAppear(){
            phraseSet1 = self.readFromFile_Da(savename: "ps0.dat")
        }
    }
    func colortextOrAudio(phraseSet: [String], arrnum: Int, defaultColor: UIColor) -> UIColor {
        var color: UIColor = defaultColor

        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("ファイルが見つかりませんでした")
            return color
        }

        let fileName = "\(phraseSet[arrnum])"
        let fileURL = documentDirectory.appendingPathComponent(fileName)

        // 録音ファイルまたはテキストファイルが存在しない場合は読み上げ
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            // No file exists, set color to default
            color = defaultColor
        } else {
            // テキストファイルが存在する場合
            if isTextFile(fileURL: fileURL) {
                // Set color to green
                color = .green
            } else {
                // 録音ファイルが存在する場合
                do {
                    // Set color to red
                    color = .red
                    // Add additional code if needed for audio playback
                } 
            }
        }

        return color
    }
    func isTextFile(fileURL: URL) -> Bool {
        do {
            let fileContent = try String(contentsOf: fileURL)
            //完成すればテキストファイル
            return true
        } catch {
            //失敗すればテキストファイルではない
            return false
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
    func ResetAllFiles() {
        let fileManager = FileManager.default
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURLs = try? fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: [])
        
        if let fileURLs = fileURLs {
            for fileURL in fileURLs {
                do {
                    try fileManager.removeItem(at: fileURL)
                } catch {
                    print("Error deleting file: \(error)")
                }
            }
        }
        
        phraseSet1 = ["こんにちは", "お腹がすいた", "こっちに来て", "ありがとう", "はい", "いいえ", "あつい", "さむい", "くるしい", "ベッド", "体", "文字盤", "トイレ", "吸引", "テレビ", "上げて", "下げて", "向きを変えて"]
        //初期設定、ファイルが存在しているか確認し、なかったい場合作る
        checkAndCreateFile(fileName: "phrarray.dat",initialContent: ["こんにちは", "お腹がすいた", "こっちに来て", "ありがとう", "はい", "いいえ", "あつい", "さむい", "くるしい", "ベッド", "体", "文字盤", "トイレ", "吸引", "テレビ", "上げて", "下げて", "向きを変えて"])
        checkAndCreateFile(fileName: "ps0.dat",initialContent: ["こんにちは", "お腹がすいた", "こっちに来て", "ありがとう", "はい", "いいえ", "あつい", "さむい", "くるしい", "ベッド", "体", "文字盤", "トイレ", "吸引", "テレビ", "上げて", "下げて", "向きを変えて"])
        checkAndCreateFile(fileName: "ps1.dat",initialContent: ["ペン", "ノート", "はさみ", "けしゴム", "えんぴつ", "シャープペンシル", "ホチキス", "リボン", "マーカー", "クリアファイル", "のり", "カッター", "シート", "テープ", "シール", "クレヨン", "ボールペン", "シャープナー"])
        checkAndCreateFile(fileName: "ps2.dat",initialContent: ["いぬ", "ねこ", "とり", "さかな", "とら", "おおかみ", "さる", "ぞう", "ひつじ", "うし", "うま", "うさぎ", "くま", "へび", "かめ", "きつね", "しか", "ちょう"])
        checkAndCreateFile(fileName: "ps3.dat",initialContent: ["にほん", "アメリカ", "カナダ", "イギリス", "フランス", "ドイツ", "ロシア", "ブラジル", "オーストラリア", "中国", "韓国", "インド", "スペイン", "イタリア", "メキシコ", "インドネシア", "トルコ", "南アフリカ"])
        checkAndCreateFile(fileName: "logdata.txt",initialContent:[])
    
    }
    func overwriteFile(from sourceURL: URL, to destinationURL: URL) {
        do {
            let sourceData = try Data(contentsOf: sourceURL)
            try sourceData.write(to: destinationURL, options: .atomic)
            print("File overwritten successfully.")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
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
            // 読み込んだ内容を戻り値として返すå
            return read_strings
        }catch{
            fatalError("ファイル読み込みエラー")
            
        }
    }
    // =================================================================================
}



