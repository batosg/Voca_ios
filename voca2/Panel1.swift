//
//  Panel1.swift
//  voca2
//
//  Created by BATORGIL on 2023/04/20.
//
import Foundation
import SwiftUI
import AVFoundation

struct Panel1: View {
    @Binding var screen: String
    @Binding var panel: Int
    @Binding var arrnum: Int
    @Binding var phraseSet1: [String]
    @Binding var phraseSet6: [String]
    @Binding var phraseSet7: [String]
    @Binding var phraseSet8: [String]
    
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
                                }else if (index==2){
                                    screen="Panel2"
                                }else if (index==3){
                                    screen="Panel3"
                                }else if (index==0){
                                    screen="option"
                                }
                            }) {
                                
                                Text(" Panel"+" \(index)")
                                    .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                                    .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                    .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.height * 0.075)
                                    .background(index == 1 ? Color.blue : Color.white)                                      //Panel数が1であれば色を青にする
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
                                    print("\(phraseSet6[index]) ")
                                    panel=1
                                    screen="record"
                                    arrnum=index
                                }) {
                                    if(index < phraseSet6.count){
                                        Text("\(phraseSet6[index]) ")
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
                                    print("\(phraseSet6[index]) ")
                                    panel=1
                                    screen="record"
                                    arrnum=index
                                }) {
                                    if(index < phraseSet6.count){
                                        Text("\(phraseSet6[index]) ")
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
                                    print("\(phraseSet6[index]) ")
                                    panel=1
                                    screen="record"
                                    arrnum=index
                                }) {
                                    if(index < phraseSet6.count){
                                        Text("\(phraseSet6[index]) ")
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
                                    print("\(phraseSet6[index]) ")
                                    panel=1
                                    screen="record"
                                    arrnum=index
                                }) {
                                    if(index < phraseSet6.count){
                                        Text("\(phraseSet6[index]) ")
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
                    
                    // 設定を初期化するボタン
                    Button(action: {
                        print("初期化")
                        panel=0
                        screen="option"
                        self.writingToFile_Da(savedata: phraseSet6, savename: "phrarray.dat")
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
                        panel=1
                        let sourceURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("ps1.dat")
                        let destinationURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("phrarray.dat")
  
                        self.writingToFile_Da(savedata: phraseSet6, savename: "ps1.dat")
                        self.writingToFile_Da(savedata: phraseSet6, savename: "phrarray.dat")
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
            phraseSet6 = self.readFromFile_Da(savename: "ps1.dat")
        }
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
            // 読み込んだ内容を戻り値として返す
            return read_strings
        }catch{
            fatalError("ファイル読み込みエラー")

        }
    }
    // =================================================================================
    
    }
    





