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
    @State private var showingAlert = false
    @Binding var screen: String

    var body: some View {
        ZStack {
            Color(red: 191/255, green: 228/255, blue: 255/255)
                .ignoresSafeArea()

            VStack {
                HStack {
                    Button(action: {
                        isShowingDialog=true
                      
                    }) {
                        Label("削除", systemImage: "trash")
                            .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                            .foregroundColor(Color.white)
                            .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.height * 0.075)
                            .background(Color(red: 255/255, green: 75/255, blue: 0))
                            .border(Color.black)
                    }.confirmationDialog("注意！",isPresented: $isShowingDialog) {
                        Button("削除する",role:.destructive){
                            writingToFile_Da(savedata: [""], savename: "logdata.txt")
                            screen="option"
                            showingAlert=true

                        }.alert(isPresented: $showingAlert) {
                            //Alert message　
                            Alert(
                                title: Text("メッセージ"),
                                message: Text("ログデータは正常に削除されました"),
                                dismissButton: .default(Text("OK"),action: {}))
                        }
                        Button("キャンセル",role:.cancel){
                            print("cancel")
                        }
                    }message: {
                        Text("全てのログデータが削除すると戻せません")
                    }
                    
                    .buttonStyle(BorderlessButtonStyle())

                    Spacer()

                    Button(action: {
                        screen = "option"
                    }) {
                        Label("戻る", systemImage: "arrowshape.turn.up.backward")
                            .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                            .foregroundColor(Color(red: 0, green:65/255, blue: 255/255))
                            .frame(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.height * 0.075)
                            .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                            .border(Color.black)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                .padding()

                Text("ログ記録")
                    .font(.largeTitle)
                    .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                    .padding(.top, 20)

                ScrollView {
                     if (fileContent.isEmpty ||  fileContent == "[\"\"]"){
                        Text("ログ記録はありません")
                            .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                            .padding()
                            .frame(minWidth: UIScreen.main.bounds.width * 0.8) // Set a default width
                    } else {
                        Text(fileContent)
                            .font(.system(size: 24, weight: .bold)) // Set the font size to 24 or adjust as needed
                                        .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                        .padding()
                                        .frame(minWidth: UIScreen.main.bounds.width * 0.8, alignment: .leading) // Set a default width with left alignment
                    }
                        
                    
                }
                .onAppear {
                    readTextFile()
                }
                .background(Color.white)
                .cornerRadius(10)
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  

    func writingToFile_Da(savedata: [String], savename: String) {
        // DocumentsフォルダURL取得
        guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("フォルダURL取得エラー")
        }
<<<<<<< HEAD
        //a
=======
        //qq
>>>>>>> Recording
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

