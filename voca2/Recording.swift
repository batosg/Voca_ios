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
    
    
    var body: some View {
        ZStack {
            Color(red: 191/255, green: 228/255, blue: 255/255).ignoresSafeArea()
            VStack{
                Picker(selection: $selection, label:Text("選択")) {
                    ForEach(0 ..< pick.count) { num in
                        Text(self.pick[num])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 800)
                //パネルを確認し、そのパネルに応じる配列を書き換える
                if(panel==0){
                    Text("\(phraseSet1[arrnum])")
                }else if(panel==1){
                    Text("\(phraseSet6[arrnum])")
                }else if(panel==2){
                    Text("\(phraseSet7[arrnum])")
                }else if(panel==3){
                    Text("\(phraseSet8[arrnum])")
                }
                TextField("表示名を入力", text: $phrase)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .font(.system(size: 50))
                    .frame(width: 600)
                
                if(selection == 1){
                    TextField("流れる音声を入力", text: $readphr)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .font(.system(size: 50))
                        .frame(width: 600)
                    
                }
                VStack{
                    if(selection == 0){
                        
                        // 録音するボタン
                        
                        Button(isRecording ? "中止" : "録音開始") {
                                        if isRecording {
                                            stopRecording()
                                        } else {
                                            startRecording()
                                        }
                                    }
                                    .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                                    .foregroundColor(Color(red: 0, green:65/255, blue: 255/255))
                                    .frame(width: UIScreen.main.bounds.width * 0.62, height: UIScreen.main.bounds.height * 0.075)
                                    .background(isRecording ? Color.red : Color.green)
                                    .border(Color.black)
                                    
                                    
                                    
                                    Button("再生") {
                                        playRecordedAudio()
                                    }
                                    .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                                    .foregroundColor(Color(red: 0, green:65/255, blue: 255/255))
                                    .frame(width: UIScreen.main.bounds.width * 0.62, height: UIScreen.main.bounds.height * 0.075)
                                    .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                                    .border(Color.black)
                                    .disabled(audioURL == nil)
                        Button("ファイル"){
                            
                            print(getDocumentsDirectory())
                        }.font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                            .foregroundColor(Color(red: 0, green:65/255, blue: 255/255))
                            .frame(width: UIScreen.main.bounds.width * 0.62, height: UIScreen.main.bounds.height * 0.075)
                            .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                            .border(Color.black)
                        
                    }else if(selection == 1){
                        Button(action: {
                            @State var utterance = AVSpeechUtterance(string: readphr)
                            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                            utterance.rate = 0.5
                            utterance.volume = playvol
                           
                            synthesiser.speak(utterance)
                            
                        }) {
                            Text("合成音声再生")
                                .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                                .foregroundColor(Color(red: 0, green:65/255, blue: 255/255))
                                .frame(width: UIScreen.main.bounds.width * 0.62, height: UIScreen.main.bounds.height * 0.075)
                                .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                                .border(Color.black)
                        }
                        
                    }
                    //Alert message
                    Button(action: {
                        if(phrase == ""){
                            showingAlert = true
                        }
                        else{
                            //書き込んでから読み込む（保存）
                            if(panel==0){
                                phraseSet1[arrnum] = phrase
                                writingToFile_Da(savedata: phraseSet1, savename: "ps0.dat")
                                phraseSet1 = readFromFile_Da(savename: "ps0.dat")
                            }else if(panel==1){
                                
                                phraseSet6[arrnum] = phrase
                                writingToFile_Da(savedata: phraseSet6, savename: "ps1.dat")
                                phraseSet6 = readFromFile_Da(savename: "ps1.dat")
                            }else if(panel==2){
                                
                                phraseSet7[arrnum] = phrase
                                writingToFile_Da(savedata: phraseSet7, savename: "ps2.dat")
                                phraseSet7 = readFromFile_Da(savename: "ps2.dat")
                            }else if(panel==3){
                                phraseSet8[arrnum] = phrase
                                writingToFile_Da(savedata: phraseSet8, savename: "ps3.dat")
                                phraseSet8 = readFromFile_Da(savename: "ps3.dat")
                               
                            }
                        }
                    }) {
                        Text("保存")
                            .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                            .foregroundColor(Color(red: 0, green:65/255, blue: 255/255))
                            .frame(width: UIScreen.main.bounds.width * 0.62, height: UIScreen.main.bounds.height * 0.075)
                            .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                            .border(Color.black)
                    }   .alert(isPresented: $showingAlert) {
                        Alert(title: Text("エラー"),message: Text("語句を入れてください"),dismissButton: .default(Text("OK"),action: {}))
                            }
                    
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
                        Text("戻る")
                            .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                            .foregroundColor(Color(red: 0, green:65/255, blue: 255/255))
                            .frame(width: UIScreen.main.bounds.width * 0.62, height: UIScreen.main.bounds.height * 0.075)
                            .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                            .border(Color.black)
                    }
                    
                }
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
func startRecording() {
    let audioSession = AVAudioSession.sharedInstance()
    do {
        try audioSession.setCategory(.playAndRecord, mode: .default)
        try audioSession.setActive(true)
        let audioFilename = getDocumentsDirectory().appendingPathComponent("\(phrase).m4a")
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
    
    func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
        isRecording = false
        audioURL = getDocumentsDirectory().appendingPathComponent("\(phrase).m4a")
    }
    
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

