//
//  Recording.swift
//  voca2
//
//  Created by GANBAT BATORGIL on 2023/04/06.
//

import Foundation
import SwiftUI
import AVFoundation


// 録音画面
struct recordView: View {
    @State private var array: [String] = []
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
    @State private var phraseSet: [[String]] = [phraseSet1, phraseSet6, phraseSet7, phraseSet8]
    // scanTimerのインスタンスを作り観測する
    @ObservedObject var scan = scanTimer()
    
    @State private var phrase = ""
    @State private var readphr = ""
    let pick = ["録音", "合成音声"]
    @State private var selection = 0
    @State private var phraseSet4: [String] = []
    @State private var showingAlert = false
    @State var synthesiser = AVSpeechSynthesizer()
    
    @State private var isRecording = false
    @State private var audioRecorder: AVAudioRecorder?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var audioURL: URL?
    @State private var word: String = ""
    
    var body: some View {
        ZStack {
            Color(red: 191/255, green: 228/255, blue: 255/255).ignoresSafeArea()
            VStack{
                Text("カストマイズ画面")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                
                
                Picker(selection: $selection, label:Text("選択")) {
                    ForEach(0 ..< pick.count) { num in
                        Text(self.pick[num])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 800)
                if panel=<0 && panel<phraseSet.count{
                    createText(phraseSet: [panel], arrnum: arrnum)
                }
                
                TextField("表示文字列を入力", text: $phrase)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
                    .font(.system(size: 50))
                    .frame(width: 600)
                //パネルを確認し、そのパネルに応じる配列を書き換える
                
                
                if(selection == 1){
                    TextField("読み上げ用テキスト", text: $readphr)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .font(.system(size: 50))
                        .frame(width: 600)
                }
                VStack{
                    if(selection == 0){
                        HStack{
                            // 録音するボタン
                            
                            
                            if isRecording {
                                Button(action: {
                                    withAnimation{
                                        
                                        stopRecording(phrase: phrase)
                                        
                                    }
                                }) {
                                    Image(systemName: "stop.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 150, height: 150)
                                        .foregroundColor(.red)
                                }
                                
                            }else{
                                Button(action: {
                                    withAnimation{
                                        startRecording(phrase : phrase)
                                    }
                                }) {
                                    Image(systemName: "mic.circle")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 150, height: 150)
                                        .foregroundColor(.blue)
                                }
                            }
                            
                            Button(action: {
                                withAnimation{
                                    playRecordedAudio()
                                }
                            }) {
                                Image(systemName: "play.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150, height: 150)
                                    .foregroundColor(.green)
                            }
                            .disabled(audioURL == nil)
                        }
                    }else if(selection == 1){
                        Button(action: {
                            withAnimation{
                                @State var utterance = AVSpeechUtterance(string: readphr)
                                utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                                utterance.rate = 0.5
                                utterance.volume = playvol
                                synthesiser.speak(utterance)
                            }
                        }) {
                            Image(systemName: "play.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                                .foregroundColor(.green)
                        }
                    }
                    
                    Button(action: {
                        
                        if(phrase == ""){
                            showingAlert = true
                        }
                        else{
                            var phraseSet: [[String]] = [phraseSet1, phraseSet6, phraseSet7, phraseSet8]
                            // Ensure panel is within valid range
                            if panel >= 0 && panel < phraseSet.count {
                                // Update the specified phraseSet array
                                phraseSet[panel][arrnum] = phrase

                                // Define the filename based on the panel
                                let filename = "ps\(panel).dat"

                                // Write to file
                                writingToFile_Da(savedata: phraseSet[panel], savename: filename)

                                // Read from file and update the corresponding phraseSet array
                                phraseSet[panel] = readFromFile_Da(savename: filename)
                            }
                        }
                        if (selection==1){
                            if(phrase==""){
                                showingAlert=true
                            }
                            else{
                                self.writingToFile_Da(savedata: [readphr], savename: "\(phrase)")
                            }
                        }
                    }) {
                        (
                            Label("保存",systemImage: "opticaldiscdrive")
                        )
                            .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                            .foregroundColor(Color(red: 0, green:65/255, blue: 255/255))
                            .frame(width: UIScreen.main.bounds.width * 0.62, height: UIScreen.main.bounds.height * 0.075)
                            .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                            .border(Color.black)
                    }   .alert(isPresented: $showingAlert) {
                        //Alert message
                        Alert(
                            title: Text("エラー"),
                            message: Text("語句を入れてください"),
                            dismissButton: .default(Text("OK"),action: {}))
                    }
//                    Button(action: {
//
//                        print(getDocumentsDirectory())
//
//                    }){
//                        Label("ファイル",systemImage: "folder")
//                            .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
//                            .foregroundColor(Color(red: 0, green:65/255, blue: 255/255))
//                            .frame(width: UIScreen.main.bounds.width * 0.62, height: UIScreen.main.bounds.height * 0.075)
//                            .background(Color(red: 200/255, green: 200/255, blue: 203/255))
//                            .border(Color.black)
//                    }
//
                    // 設定画面に遷移するボタン
                    //最後に入った画面に応じて戻る
                    Button(action: {
                        if(panel==0){
                            screen="option"
                        }else if(panel==1){
                            screen="Panel1"
                        }else if(panel==2){
                            screen="Panel2"
                        }else if(panel==3){
                            screen="Panel3"
                        }
                        
                    }) {
                        Label("戻る",systemImage: "arrowshape.turn.up.backward")
                            .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                            .foregroundColor(Color(red: 0, green:65/255, blue: 255/255))
                            .frame(width: UIScreen.main.bounds.width * 0.62, height: UIScreen.main.bounds.height * 0.075)
                            .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                            .border(Color.black)
                    }
                }
                Spacer()
            }
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
    func createText(phraseSet: [String], arrnum: Int) -> some View {
        return Text("\(phraseSet[arrnum])")
            .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
            .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
            .frame(width: UIScreen.main.bounds.width * 0.16, height: UIScreen.main.bounds.height * 0.08)
            .border(Color.black)
            .background(Color.white)
    }
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
    
    //録音開始(拡張子がないので注意)
    func startRecording(phrase : String) {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            let audioFilename = getDocumentsDirectory().appendingPathComponent(phrase)
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.record()
            isRecording = true
        } catch {
            print("Failed to start recording: \(error.localizedDescription)")
            
        }
    }
    //録音停止
    func stopRecording(phrase : String) {
        audioRecorder?.stop()
        audioRecorder = nil
        isRecording = false
        audioURL = getDocumentsDirectory().appendingPathComponent(phrase)
    }
    //録音再生
    func playRecordedAudio() {
        guard let url = audioURL else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Failed to play recorded audio")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
}

