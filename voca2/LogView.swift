//
//  LogView.swift
//  voca2
//
//  Created by BATORGIL on 2023/10/16.
//
import SwiftUI
import UniformTypeIdentifiers
struct LogView: View {
    @State private var fileContent: [String] = []
    @State private var selectedDate: Date = Date()
    @State private var isShowingDialog = false
    @State private var showingAlert = false
    @Binding var screen: String
    //cr lf 
    var body: some View {
        
        ZStack {
            Color(red: 191/255, green: 228/255, blue: 255/255)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    //ログ初期化
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
                            //
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
                    VStack{
                        //ログ書き込み
                        Button(action: {
                            exportLog()
                        }) {
                            Label("共有", systemImage: "square.and.arrow.up")
                                .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                                .foregroundColor(Color(red: 0, green:65/255, blue: 255/255))
                                .frame(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.height * 0.075)
                                .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                                .border(Color.black)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    
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
                }
                Text("ログ記録")
                                .font(.largeTitle)
                                .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                .padding(.top, 20)

                            DatePicker(
                                "日付を選択してください",
                                selection: $selectedDate,
                                displayedComponents: [.date]
                            )
                            .padding()
                            .environment(\.locale, Locale(identifier: "ja_JP"))

                ScrollView {
                    if let logsForSelectedDate = logsForDate(selectedDate) {
                        if logsForSelectedDate.isEmpty {
                            Text("選択した日のログ記録はございません")
                                .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                .padding()
                                .frame(minWidth: UIScreen.main.bounds.width * 0.8)
                        } else {
                            ForEach(logsForSelectedDate, id: \.self) { log in
                                Text(log)
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                    .padding()
                                    .frame(minWidth: UIScreen.main.bounds.width * 0.8, alignment: .leading)
                            }
                        }
                    } else {
                        Text("ログ記録はございません")
                            .foregroundColor(Color.red)
                            .padding()
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
    //正しいフォーマットに書き込む
    func logsForDate(_ date: Date) -> [String]? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy年 MM月 d日"

        let formattedDate = formatter.string(from: date)

        let logsForSelectedDate = fileContent.filter { logEntry in
            if let index = logEntry.range(of: formattedDate) {
                // Extract the date portion and ignore the characters after it
                let dateString = logEntry[..<index.upperBound]
                return dateString.trimmingCharacters(in: .whitespaces) == formattedDate
            }
            return false
        }

        if logsForSelectedDate.isEmpty {
            return nil
        } else {
            return logsForSelectedDate
        }
    } 


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
    //ログ書き込み
    func exportLog() {
        let fileName = "logdata_export.txt"

        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)

        do {
            let logTextContent = fileContent.joined(separator: "\n")

            try logTextContent.write(to: tempURL, atomically: true, encoding: .utf8)

            let interactionController = UIDocumentInteractionController(url: tempURL)

            if !interactionController.presentOptionsMenu(from: .zero, in: UIApplication.shared.windows.first?.rootViewController?.view ?? UIView(), animated: true) {
            }

        } catch {
            print("書き込みエラー: \(error.localizedDescription)")
        }
    }

    func readTextFile() {
        let fileName = "logdata.txt"
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentDirectory.appendingPathComponent(fileName)

        do {
            // Read the file content as an array of strings
            fileContent = try String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n").filter { !$0.isEmpty }
        } catch {
            print("読み込みエラー: \(error)")
        }
    }

}

