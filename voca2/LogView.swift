//
//  LogView.swift
//  voca2
//
//  Created by BATORGIL on 2023/10/16.
//

import SwiftUI

struct LogView: View {
    @State private var fileContent: String = ""
    @State private var isShowingDialog = false
    @Binding var screen:String
    var body: some View {
        HStack{
            ScrollView {
                VStack {
                    Text("ログ記録:")
                    Text(fileContent)
                        .padding()
                }
            }
            .onAppear {
                readTextFile()
            }
            VStack{
                Button(action: {
                    isShowingDialog = true
                    
                }) {
                    Label("消去",systemImage: "trash")
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        
                    
                }.confirmationDialog("注意", isPresented: $isShowingDialog){
                    Button("消去する",role: .destructive){
                        writingToFile_Da(savedata: [""], savename: "logdata.txt")
                        screen = "option"
                    }
                    Button("キャンセル",role: .cancel){
                        print("cancel")
                    }
                }message:{
                        Text("消去すると戻せません")
                    }
                
                Button(action: {
                    screen = "option"
                }) {
                    Label("戻る",systemImage: "arrowshape.turn.up.backward")
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        
                }
            }
        }
        .padding(.trailing)
    }
    
    func writingToFile_Da(savedata: [String], savename: String) {
        // DocumentsフォルダURL取得
        guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("フォルダURL取得エラー")
        }
        //
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
    func readTextFile() {
        let fileName = "logdata.txt"
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            do {
                // Read file content
                fileContent = try String(contentsOf: fileURL, encoding: .utf8)
            } catch {
                print("Error reading file: \(error)")
            }
        }
    }
}

