//
//  Panel3.swift
//  voca2
//
//  Created by BATORGIL on 2023/04/20.
//
import Foundation
import SwiftUI
import AVFoundation

struct Panel3: View {
    @Binding var screen: String
    @Binding var panel: Int
    @State private var phraseSet1: [String] = ["こんにちは", "お腹がすいた", "こっちに来て", "ありがとう", "はい", "いいえ", "あつい", "さむい", "くるしい", "ベッド", "体", "文字盤", "トイレ", "吸引", "テレビ", "上げて", "下げて", "向きを変えて"]
    @State private var phraseSet6: [String] = ["ZZZZZZ", "AAA", "こっちに来て", "ありがとう", "はい", "いいえ", "あつい", "さむい", "くるしい", "ベッド", "体", "文字盤", "トイレ", "吸引", "テレビ", "上げて", "下げて", "向きを変えて"]
    @State private var phraseSet7: [String] = ["ZAZAZA", "AAA", "こっちに来て", "ありがとう", "はい", "いいえ", "あつい", "さむい", "くるしい", "ベッド", "体", "文字盤", "トイレ", "吸引", "テレビ", "上げて", "下げて", "向きを変えて"]
    @State private var phraseSet8: [String] = ["QQQQQ", "AAA", "こっちに来て", "ありがとう", "はい", "いいえ", "あつい", "さむい", "くるしい", "ベッド", "体", "文字盤", "トイレ", "吸引", "テレビ", "上げて", "下げて", "向きを変えて"]
    
   
    var body: some View {
        
        
    
            ZStack {
                Color(red: 191/255, green: 228/255, blue: 255/255).ignoresSafeArea()
                
                    HStack {
                        VStack {
                            HStack{
                               
                                
                                ForEach(0..<4) { index in
                                    Button(action: {
                                        if(index==1){
                                            screen="Panel1"
                                            self.writingToFile_Da(savedata: phraseSet8, savename: "phrarray.dat")
                                        }else if (index==2){
                                            screen="Panel2"
                                            self.writingToFile_Da(savedata: phraseSet6, savename: "phrarray.dat")
                                        }else if (index==3){
                                            screen="Panel3"
                                            self.writingToFile_Da(savedata: phraseSet7, savename: "phrarray.dat")

                                        }else if (index==0){
                                            screen="option"
                                            self.writingToFile_Da(savedata: phraseSet1, savename: "phrarray.dat")
                                        }
                                    }) {
                                        
                                        Text(" Panel"+" \(index)")
                                            .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                                            .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                            .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.height * 0.075)
                                            .background(index == 3 ? Color.blue : Color.white)                  //Panel数が3であれば色を青にする
                                            .border(Color.black)
                                    }
                                }
                            }
                            
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
                                            print("\(phraseSet7[index]) ")
                                        }) {
                                            if(index < phraseSet7.count){
                                            Text("\(phraseSet7[index]) ")
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
                                    ForEach(4..<9) { index in
                                        Button(action: {
                                            print("\(phraseSet7[index]) ")
                                            
                                        }) {
                                            if(index < phraseSet7.count){
                                            Text("\(phraseSet7[index]) ")
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
                                            print("\(phraseSet7[index]) ")
                                            
                                        }) {
                                            if(index < phraseSet7.count){
                                            Text("\(phraseSet7[index]) ")
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
                                            print("\(phraseSet7[index]) ")
                                            
                                        }) {
                                            if(index < phraseSet7.count){
                                            Text("\(phraseSet7[index]) ")
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
                            // 録音画面に遷移するボタン
                            Button(action: {
                                screen = "record"
                                panel=3
                            }) {
                                Text("新規語句設定")
                                    .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                                    .foregroundColor(Color(red: 0, green:65/255, blue: 255/255))
                                    .frame(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.height * 0.075)
                                    .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                                    .border(Color.black)
                            }
                            // 設定を初期化するボタン
                            Button(action: {
                                print("初期化")
                                panel=0
                                screen="option"
                                self.writingToFile_Da(savedata: phraseSet1, savename: "phrarray.dat")
                            }) {
                                Text("初期化")
                                    .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                                    .foregroundColor(Color.white)
                                    .frame(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.height * 0.075)
                                    .background(Color(red: 255/255, green: 75/255, blue: 0))
                                    .border(Color.black)
                            }
                            // 定型句画面に戻るボタン
                            Button(action: {
                                screen = "phrase"
                                panel=3
                                
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
            }//.onAppear(){
                //self.writingToFile_Da(savedata: phraseSet5, savename: "phrarray.dat")
                //phraseSet5 = self.readFromFile_Da(savename: "phrarray.dat")
                
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
    





