//
//  PhraseView.swift
//  voca2
//
//  Created by GANBAT BATORGIL on 2023/04/06.



import Foundation
import SwiftUI
import AVFoundation

// 定型句VOCA画面
struct phraseView: View {
    // ContentViewの変数をバインディングする
    @Binding var screen: String
    @Binding var theText: String
    @Binding var playvol: Float
    @Binding var panel: Int
    @State var synthesiser = AVSpeechSynthesizer()
    @State var phraseSet2: [String] = []
    @State var mytextArray:[String]=[]
    @State var mytext:String=""
    @ObservedObject var scan = scanTimer()  // scanTimerのインスタンスを作り観測する
   
    @State var onsei:Int=0
    private let buttonTexts = ["読み上げ\n\n音声", "読み上げ\n\n効果音", "読み上げ\n\n音声なし"]
    
    @State var scanNum:Int=0
    private let scanTexts = ["スキャン範囲\n\n機能あり","スキャン範囲\n定型句\nのみ"]
    
    @State private var audioURL: URL?
    @State private var audioRecorder: AVAudioRecorder?
    @State private var audioPlayer: AVAudioPlayer?
    private let buttonVoice = [try! AVAudioPlayer(data: NSDataAsset(name: "konnitiwa")!.data),
                               try! AVAudioPlayer(data: NSDataAsset(name: "onakasuita")!.data),
                               try! AVAudioPlayer(data: NSDataAsset(name: "come")!.data),
                               try! AVAudioPlayer(data: NSDataAsset(name: "thanks")!.data),
                               try! AVAudioPlayer(data: NSDataAsset(name: "yes")!.data),
                               try! AVAudioPlayer(data: NSDataAsset(name: "no")!.data),
                               try! AVAudioPlayer(data: NSDataAsset(name: "hot")!.data),
                               try! AVAudioPlayer(data: NSDataAsset(name: "cold")!.data),
                               try! AVAudioPlayer(data: NSDataAsset(name: "kurusii")!.data),
                               try! AVAudioPlayer(data: NSDataAsset(name: "bed")!.data),
                               try! AVAudioPlayer(data: NSDataAsset(name: "body")!.data),
                               try! AVAudioPlayer(data: NSDataAsset(name: "moziban")!.data),
                               try! AVAudioPlayer(data: NSDataAsset(name: "toilet")!.data),
                               try! AVAudioPlayer(data: NSDataAsset(name: "kyuuin")!.data),
                               try! AVAudioPlayer(data: NSDataAsset(name: "tv")!.data),
                               try! AVAudioPlayer(data: NSDataAsset(name: "up")!.data),
                               try! AVAudioPlayer(data: NSDataAsset(name: "down")!.data),
                               try! AVAudioPlayer(data: NSDataAsset(name: "change")!.data)]
    
    var body: some View {
        ZStack {
            Color(red: 191/255, green: 228/255, blue: 255/255).ignoresSafeArea()
            
            VStack {
                HStack {
                    VStack {
                        // 読み上げ切替ボタン
                        Button(action: {
                                    onsei = (onsei + 1) % buttonTexts.count
                            if (scan.waiting==true){
                                print("change")
                            }
                                
                                
                                }) {
                                    Text(buttonTexts[onsei])
                                        .font(.system(size: UIScreen.main.bounds.width * 0.02, weight: .medium))
                                        .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                        .frame(width: UIScreen.main.bounds.width * 0.12, height: UIScreen.main.bounds.height * 0.16)
                                        .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                                        .cornerRadius(15.0)
                                }
                        .padding(/*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                        
                        // 設定ボタン
                        //前に開けたパネルが設定ボタンを押すと表示される
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
                            Text("設定")
                                .font(.system(size: UIScreen.main.bounds.width * 0.03, weight: .medium))
                                .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                .frame(width: UIScreen.main.bounds.width * 0.12, height: UIScreen.main.bounds.height * 0.16)
                                .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                                .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                        }
                    }
                    // フィールド
                    ZStack {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width * 0.66, height: UIScreen.main.bounds.height * 0.38)
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color(red: 255/255, green: 202/255, blue: 128/255))
                        
                        Text("\(theText)")
                            .font(.system(size: UIScreen.main.bounds.width * 0.035, weight: .bold))
                            .frame(width: UIScreen.main.bounds.width * 0.64, height: UIScreen.main.bounds.height * 0.36, alignment: .topLeading)
                    }
                    .padding(.horizontal)
                    
                    // スキャン範囲切替ボタン
                    VStack {
                        Button(action: {
                                    scanNum = (scanNum + 1) % scanTexts.count
                            
                                }) {
                                    Text(scanTexts[scanNum])
                                        .font(.system(size: UIScreen.main.bounds.width * 0.02, weight: .medium))
                                        .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                        .frame(width: UIScreen.main.bounds.width * 0.12, height: UIScreen.main.bounds.height * 0.16)
                                        .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                                        .cornerRadius(15.0)
                                }
                        .padding(/*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                        // スキャンボタン
                        ZStack {
                            createScanButton(shortcut: .space) // スキャンボタン
                            createScanButton(shortcut: "1") // スキャンボタン
                            createScanButton(shortcut: "3") // スキャンボタン
                        }
                    }
                }
                .padding(.bottom)
                
                HStack {
                    VStack {
                        
                        HStack{
                            // Column 1
                            VStack {
                                // 読み上げボタン
                                Button(action: {
                                    let utterance = AVSpeechUtterance(string: theText)
                                    utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                                    utterance.rate = 0.5
                                    utterance.volume = playvol
                                   
                                    synthesiser.speak(utterance)
                                }) {
                                    Text("読み上げ")
                                        .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                                        .foregroundColor(Color.white)
                                        .frame(width: UIScreen.main.bounds.width * 0.16, height: UIScreen.main.bounds.height * 0.08)
                                        .background(Color(red: 3/255, green: 175/255, blue: 122/255))
                                    // オートスキャンで太さと色が変わる枠
                                        .border(((scan.count == 0 || scan.count == 25) && scan.waiting == false) ? Color(red: 0, green: 90/255, blue: 255/255) : Color.black, width: (((scan.count == 0 || scan.count == 25) && scan.waiting == false) ? 6 : 1))
                                }
                                ForEach(0..<4) { index in
                                    createButton(index: index)
                                }
                            }
                            
                            // Column 2
                            VStack {
                                ForEach(4..<9) { index in
                                    createButton(index: index)
                                }
                            }
                            
                            // Column 3
                            VStack {
                                ForEach(9..<14) { index in
                                    createButton(index: index)
                                }
                            }
                            
                            // Column 4
                            VStack {
                                ForEach(14..<18) { index in
                                    createButton(index: index)
                                }
                                // 消去ボタン
                                Button(action: {
                                    theText = ""
                                }) {
                                    Text("消去")
                                        .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                                        .foregroundColor(Color.white)
                                        .frame(width: UIScreen.main.bounds.width * 0.16, height: UIScreen.main.bounds.height * 0.08)
                                        .background(Color(red: 255/255, green: 75/255, blue: 0))
                                    // オートスキャンで太さと色が変わる枠
                                        .border(((scan.count == 19 || scan.count == 44) && scan.waiting == false) ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: (((scan.count == 19 || scan.count == 44) && scan.waiting == false) ? 6 : 1))
                                }
                            }
                            }
                        }
                       
                    
                    // 画面切替ボタン
                    VStack {
                        Button(action: {
                            screen = "hiragana"  // 50音文字盤（清音ひらがな）への遷移
                        }) {
                            Text("50音")
                                .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                                .foregroundColor(Color.white)
                                .frame(width: UIScreen.main.bounds.width * 0.16, height: UIScreen.main.bounds.height * 0.08)
                                .background(Color(red: 3/255, green: 175/255, blue: 122/255))
                            // オートスキャンで太さと色が変わる枠
                                .border(((scan.count == 20 || scan.count == 45) && scan.waiting == false) ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: (((scan.count == 20 || scan.count == 45) && scan.waiting == false) ? 6 : 1))
                        }
                        .padding(.bottom)
                        
                        Text("速度").font(.system(size: UIScreen.main.bounds.width * 0.022))
                        
                        HStack {
                            ZStack {
                                // 速度変更ボタン（加速）
                                Button(action: {
                                    if (scan.speed > 0.3) {
                                        scan.speedUp(phraseset: phraseSet2)  // 加速
                                    }
                                }) {
                                    Text("-")
                                        .font(.system(size: UIScreen.main.bounds.width * 0.03, weight: .black))
                                        .foregroundColor(Color.white)
                                    // 塗りつぶされた三角形
                                        .background(
                                            leftTriangle()
                                                .fill(Color(red: 255/255, green: 128/255, blue: 130/255))
                                                .frame(width: UIScreen.main.bounds.height * 0.06, height: UIScreen.main.bounds.height * 0.08)
                                        )
                                }
                                // 枠のみの三角形（オートスキャンで枠の太さと色が変わる）
                                leftTriangle()
                                    .stroke(((scan.count == 21 || scan.count == 46) && scan.waiting == false) ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, lineWidth: (((scan.count == 21 || scan.count == 46) && scan.waiting == false) ? 6 : 1))
                                    .frame(width: UIScreen.main.bounds.height * 0.06, height: UIScreen.main.bounds.height * 0.08)
                            }
                            
                            // 速度フィールド
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width * 0.06, height: UIScreen.main.bounds.height * 0.08)
                                
                                Text("\(String(format: "%.1f", scan.speed))")
                                    .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .medium))
                            }
                            
                            ZStack {
                                // 速度変更ボタン（減速）
                                Button(action: {
                                    if (scan.speed < 1.9) {
                                        scan.speedDown(phraseset: phraseSet2)  // 減速
                                    }
                                }) {
                                    Text("+")
                                        .font(.system(size: UIScreen.main.bounds.width * 0.03, weight: .black))
                                        .foregroundColor(Color.white)
                                    // 塗りつぶされた三角形
                                        .background(
                                            rightTriangle()
                                                .fill(Color(red: 255/255, green: 128/255, blue: 130/255))
                                                .frame(width: UIScreen.main.bounds.height * 0.06, height: UIScreen.main.bounds.height * 0.08)
                                        )
                                }
                                // 枠のみの三角形（オートスキャンで枠の太さと色が変わる）
                                rightTriangle()
                                    .stroke(((scan.count == 22 || scan.count == 47) && scan.waiting == false) ? Color(red: 0, green: 90/255, blue: 255/255) : Color.black, lineWidth: (((scan.count == 22 || scan.count == 47) && scan.waiting == false) ? 6 : 1))
                                    .frame(width: UIScreen.main.bounds.height * 0.06, height: UIScreen.main.bounds.height * 0.08)
                            }
                        }
                        
                        Text("音量").font(.system(size: UIScreen.main.bounds.width * 0.022))
                        
                        HStack {
                            ZStack {
                                // 音量変更ボタン（-）
                                Button(action: {
                                    if (playvol > 0) {
                                        playvol -= 0.1
                                    }
                                }) {
                                    Text("-")
                                        .font(.system(size: UIScreen.main.bounds.width * 0.03, weight: .black))
                                        .foregroundColor(Color.white)
                                    // 塗りつぶされた三角形
                                        .background(
                                            leftTriangle()
                                                .fill(Color(red: 255/255, green: 128/255, blue: 130/255))
                                                .frame(width: UIScreen.main.bounds.height * 0.06, height: UIScreen.main.bounds.height * 0.08)
                                        )
                                }
                                // 枠のみの三角形（オートスキャンで枠の太さと色が変わる）
                                leftTriangle()
                                    .stroke(((scan.count == 23 || scan.count == 48) && scan.waiting == false) ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, lineWidth: (((scan.count == 23 || scan.count == 48) && scan.waiting == false) ? 6 : 1))
                                    .frame(width: UIScreen.main.bounds.height * 0.06, height: UIScreen.main.bounds.height * 0.08)
                            }
                            
                            // 音量フィールド
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width * 0.06, height: UIScreen.main.bounds.height * 0.08)
                                
                                Text("\(String(format: "%0.1f", playvol))")
                                    .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .medium))
                            }
                            
                            ZStack {
                                // 音量変更ボタン（+）
                                Button(action: {
                                    if (playvol < 1.0) {
                                        playvol += 0.1
                                    }
                                }) {
                                    Text("+")
                                        .font(.system(size: UIScreen.main.bounds.width * 0.03, weight: .black))
                                        .foregroundColor(Color.white)
                                    // 塗りつぶされた三角形
                                        .background(
                                            rightTriangle()
                                                .fill(Color(red: 255/255, green: 128/255, blue: 130/255))
                                                .frame(width: UIScreen.main.bounds.height * 0.06, height: UIScreen.main.bounds.height * 0.08)
                                        )
                                }
                                // 枠のみの三角形（オートスキャンで枠の太さと色が変わる）
                                rightTriangle()
                                    .stroke(((scan.count == 24 || scan.count == 49) && scan.waiting == false) ? Color(red: 0, green: 90/255, blue: 255/255) : Color.black, lineWidth: (((scan.count == 24 || scan.count == 49) && scan.waiting == false) ? 6 : 1))
                                    .frame(width: UIScreen.main.bounds.height * 0.06, height: UIScreen.main.bounds.height * 0.08)
                            }
                        }
                    }
                }
            }
        }.onAppear(){
            phraseSet2 = self.readFromFile_Da(savename: "phrarray.dat")//配列を代入
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    //============================================================================================================================================================================================================================
    func playaudio(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("ファイルが見つかりませんでした")
            return
        }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        //録音ファイルまたはテキストファイルが存在しない場合は読み上げ
            if !FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    let utterance = AVSpeechUtterance(string: fileName)
                    utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                    utterance.rate = 0.5
                    utterance.volume = playvol
                    synthesiser.speak(utterance)
                }
                //テキストファイルが存在する場合
            } else {
                if(isTextFile(fileURL:fileURL)==true){
                    do{
                        print(fileName)
                       
                        
                        //print("File Contents:", String(data: fileContents, encoding: .utf8) ?? "Unable to convert data to string")

                        let mytextArray = self.readFromFile_Da(savename: fileName)
                        let mytext = mytextArray.joined(separator: "") //配列をStringに変換
                        let utterance = AVSpeechUtterance(string: mytext)
                        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                        utterance.rate = 0.5
                        utterance.volume = playvol
                        synthesiser.speak(utterance)
                        print("Text file found")
                   }
                }else{
                    //録音ファイルが存在する場合
                    
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
                        audioPlayer?.play()
                    } catch {
                        print("ファイルを再生できませんでした")
                    }
                }
            }
    }
//  ===================================================================================================================================================
    private func createScanButton(shortcut: KeyEquivalent) -> some View {
            return Button(action: {
                
                    phraseScanAction() // スキャンボタン押下時の処理
                
            }) {
                Text("スキャン")
                    .font(.system(size: UIScreen.main.bounds.width * 0.02, weight: .medium))
                    .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                    .frame(width: UIScreen.main.bounds.width * 0.12, height: UIScreen.main.bounds.height * 0.16)
                    .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                    .cornerRadius(15.0)
            }
            .keyboardShortcut(shortcut, modifiers: [])
        }
    //    ============================================================================================================================================================================================================================
    func createButton(index: Int) -> some View {
        Button(action: {
            playaudio(fileName: "\(phraseSet2[index])")
            theText+=(" "+phraseSet2[index])
        }) {
            if (index < phraseSet2.count) {
                Text("\(phraseSet2[index])")
                    .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                    .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                    .frame(width: UIScreen.main.bounds.width * 0.16, height: UIScreen.main.bounds.height * 0.08)
                    .border(((scan.count == index + 1 || scan.count == index + 26) && scan.waiting == false) ? Color(red: 0, green: 90/255, blue: 255/255) : Color.black, width: (((scan.count == index + 1 || scan.count == index + 26) && scan.waiting == false) ? 6 : 1))
                    .background(Color.white)
            } else {
                EmptyView()
            }
        }
    }
    func isTextFile(fileURL: URL) -> Bool {
        do {
            let fileContent = try String(contentsOf: fileURL)
            // If decoding as String succeeds, it's likely a text file
            return true
        } catch {
            // Failed to decode as String, may not be a text file
            return false
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
        } catch{
            print("Error reading file:", error)
                    return []  // Return an empty array or handle the error accordingly
                }
    }
    // =================================================================================
    
    func phraseScanAction() {
        if (screen == "phrase") {
            if scan.waiting {
                
                scan.phraseStart(phraseSet2: phraseSet2,speed: 0.83-(scan.speed)/3,mode:onsei) // オートスキャン開始 ,早さの設定
            } else {
                // オートスキャンによるボタン選択
                if (scan.count == 0 || scan.count == 25) {
                    let utterance = AVSpeechUtterance(string: theText)
                    utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                    utterance.rate = 0.5
                    
                    utterance.volume = playvol
                    let synthesiser = AVSpeechSynthesizer()
                    synthesiser.speak(utterance)
                } else if (scan.count > 0 && scan.count < 19) {
                    theText += "\(phraseSet2[scan.count - 1]) "
                    let utterance = AVSpeechUtterance(string: (phraseSet2[scan.count - 1]))
                    synthesiser.speak(utterance)
                } else if (scan.count > 25 && scan.count < 44) {
                    theText += "\(phraseSet2[scan.count - 26])"
                    let utterance = AVSpeechUtterance(string: (phraseSet2[scan.count - 26]))
                    synthesiser.speak(utterance)
                } else if (scan.count == 19 || scan.count == 44) {
                    theText = ""
                } else if (scan.count == 20 || scan.count == 45) {
                    screen = "hiragana"  //50音文字盤（清音ひらがな）への遷移
                } else if ((scan.count == 21 || scan.count == 46) && scan.speed < 1.9) {
                    scan.speedUp(phraseset: phraseSet2)
                } else if ((scan.count == 22 || scan.count == 47) && scan.speed > 0.3) {
                    scan.speedDown(phraseset: phraseSet2)
                } else if ((scan.count == 23 || scan.count == 48) && playvol < 10) {
                    playvol += 0.1
                } else if ((scan.count == 24 || scan.count == 49) && playvol > 0) {
                    playvol -= 0.1
                }
                scan.stop() // オートスキャン終了
            }
        }
    }
}
