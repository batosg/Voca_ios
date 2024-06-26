//
//  scanTimer.swift
//  voca2
//
//  Created by 髙橋大 on 2022/04/06.
//

import Foundation
import SwiftUI
import AVFoundation

class scanTimer: ObservableObject {
    @State private var isSpeaking = false
    @State private var activePlayerIndex: Int?
    @State var audioPlayer: AVAudioPlayer?
    // 値の更新をパブリッシュする変数にする（これとContentViewでのObservedObjectの宣言により、ContentViewでの観測が可能となる）
    let synthesiser = AVSpeechSynthesizer()
    //@State var audioPlayer: AVAudioPlayer
    @State var isPlaying: Bool = false
    @State var playvol: Float = 1.0
    @Published var count: Int = 0  // 定型句VOCA画面のカウント
    @Published var firstCount: Int = 0  // 50音文字盤VOCA画面の行ごとのカウント
    @Published var secondCount: Int = 0  // 50音文字盤VOCA画面のボタン一つずつのカウント
    @Published var waiting = true  // true：オートスキャン停止中, false：オートスキャン動作中
    @Published var selected = ""  // 50音文字盤VOCA画面で何を選んだか（aiueo：清音ひらがなで行ごとのオートスキャンを開始, gagigugego：(半)濁音ひらがなで行ごとのオートスキャンを開始, kirikaeToDelete：行ごとのオートスキャンで画面切替ボタン〜消去ボタンの行を選択, hitomoji：行ごとのオートスキャンで50音文字ボタンのいずれかの行を選択, speedVolume：行ごとのオートスキャンで速度・音量変更ボタンのブロックを選択）
    @Published var speed = 1.0  // オートスキャンの速度（秒）
    @Published var line: Int = 0  // 選択した行（あ(濁音画面はが)行なら0, か(濁音画面はざ)行なら5, さ(濁音画面はだ)行なら10, ...）
    @Published var cScr = "phrase"  // 現在の画面（ContentViewのcurrentScreenと似ているが連携はしていない）
    @Published var hiraganaSet = ["あ", "い", "う", "え", "お",
                                  "か", "き", "く", "け", "こ",
                                  "さ", "し", "す", "せ", "そ",
                                  "た", "ち", "つ", "て", "と",
                                  "な", "に", "ぬ", "ね", "の",
                                  "は", "ひ", "ふ", "へ", "ほ",
                                  "ま", "み", "む", "め", "も",
                                  "や", "　", "ゆ", "　", "よ",
                                  "ら", "り", "る", "れ", "ろ",
                                  "わ", "を", "ん", "　"]
    @Published var dakuHiraSet = ["が", "ぎ", "ぐ", "げ", "ご",
                                  "ざ", "じ", "ず", "ぜ", "ぞ",
                                  "だ", "ぢ", "づ", "で", "ど",
                                  "ば", "び", "ぶ", "べ", "ぼ",
                                  "ぱ", "ぴ", "ぷ", "ぺ", "ぽ",
                                  "ぁ", "ぃ", "ぅ", "ぇ", "ぉ",
                                  "っ", "ゃ", "ゅ", "ょ", "ー",
                                  "　", "　", "　", "　"]
    @Published var katakanaSet = ["ア", "イ", "ウ", "エ", "オ",
                                  "カ", "キ", "ク", "ケ", "コ",
                                  "サ", "シ", "ス", "セ", "ソ",
                                  "タ", "チ", "ツ", "テ", "ト",
                                  "ナ", "ニ", "ヌ", "ネ", "ノ",
                                  "ハ", "ヒ", "フ", "ヘ", "ホ",
                                  "マ", "ミ", "ム", "メ", "モ",
                                  "ヤ", "　", "ユ", "　", "ヨ",
                                  "ラ", "リ", "ル", "レ", "ロ",
                                  "ワ", "ヲ", "ン", "　"]
    @Published var dakuKataSet = ["ガ", "ギ", "グ", "ゲ", "ゴ",
                                  "ザ", "ジ", "ズ", "ゼ", "ゾ",
                                  "ダ", "ヂ", "ヅ", "デ", "ド",
                                  "バ", "ビ", "ブ", "ベ", "ボ",
                                  "パ", "ピ", "プ", "ペ", "ポ",
                                  "ァ", "ィ", "ゥ", "ェ", "ォ",
                                  "ッ", "ャ", "ュ", "ョ", "ー",
                                  "　", "　", "　", "　"]
    private var timer = Timer()
    // 各定型句ボタンのオートスキャン時読み上げの音声
    private let scanVoice = [try! AVAudioPlayer(data:NSDataAsset(name: "yomiage")!.data),
                             try! AVAudioPlayer(data: NSDataAsset(name: "konnitiwa_b")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "onakasuita_b")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "come_b")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "thanks_b")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "yes_b")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "no_b")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "hot_b")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "cold_b")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "kurusii_b")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "bed_b")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "body_b")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "moziban_b")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "toilet_b")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "kyuuin_b")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "tv_b")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "up_b")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "down_b")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "change_b")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "delete")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "kirikae")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "fast")!.data),
                             try! AVAudioPlayer(data:NSDataAsset(name: "slow")!.data),
                             try! AVAudioPlayer(data: NSDataAsset(name: "se_maoudamashii_system35")!.data)]
    
    // 定型句VOCA画面のオートスキャン開始
    func phraseStart(phraseSet2:[String],speed: Double,mode:Int,scanmode:Int) {
        self.waiting = false
        self.scanVoice[0].play()
  
        print("スキャン開始")
        if(scanmode==0){
            // タイマー起動
            timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) { [self] _ in
                self.count += 1
                if(mode==0){
                    if synthesiser.isSpeaking {                             //音声が重なることがなくなる
                        synthesiser.stopSpeaking(at: .immediate)
                        isSpeaking = false
                    }
                    // オートスキャン時の読み上げ
                    if (self.count == 25) {
                        self.scanVoice[0].play()  // 「読み上げ」
                    } else if (self.count > 0 && self.count < 19) {
                        print(scanmode)
                        
                        let utterance = AVSpeechUtterance(string: phraseSet2[self.count-1])
                        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                        if(speed<0.5){
                            utterance.rate = 0.5
                        }else{
                            utterance.rate = Float(speed)
                        }
                        utterance.volume = self.playvol
                        
                        synthesiser.speak(utterance) // 定型句
                        
                    } else if (self.count > 25 && self.count < 44) {
                        let utterance = AVSpeechUtterance(string: phraseSet2[self.count-26])
                        self.synthesiser.speak(utterance) // 定型句
                    } else if (self.count == 19 || self.count == 44) {
                        self.scanVoice[19].play()  // 「消去」
                    } else if (self.count == 20 || self.count == 45) {
                        self.scanVoice[20].play()  // 「切り替え」
                    } else if (self.count == 21 || self.count == 46) {
                        self.scanVoice[21].play()  // 「早く」
                    } else if (self.count == 22 || self.count == 47) {
                        self.scanVoice[22].play()  // 「遅く」1
                    } else if (self.count > 49) {
                        self.stop()  // 2周で終了
                        print("終")
                    }
                }else if(mode==1){
                    if(self.count<48){
                        print(scanmode)
                        self.scanVoice[23].stop()
                        self.scanVoice[23].play()
                    }else{
                        self.stop()
                    }
                }else if(mode==2){
                    print(scanmode)
                    if(self.count>49){
                        self.stop()
                    }
                }
            }
            
        }else if (scanmode==1){
            
            timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) { [self] _ in
                self.count += 1
                if(mode==0){
                    if synthesiser.isSpeaking {                             //音声が重なることがなくなる
                        synthesiser.stopSpeaking(at: .immediate)
                        isSpeaking = false
                    }
                    // オートスキャン時の読み上げ
                    if (self.count == 25) {
                        print(scanmode)
                        self.scanVoice[0].play()  // 「読み上げ」
                    } else if (self.count > 0 && self.count < 19) {
                        print(scanmode)
                        let utterance = AVSpeechUtterance(string: phraseSet2[self.count-1])
                        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                        if(speed<0.5){
                            utterance.rate = 0.5
                        }else{
                            utterance.rate = Float(speed)
                        }
                        utterance.volume = self.playvol
                        synthesiser.speak(utterance) // 定型句
                    }else if (self.count==19 || self.count==44 ) {
                        self.scanVoice[0].stop()
                        self.scanVoice[19].play()
                    }else if (self.count==20){
                        self.count=25
                        self.scanVoice[0].play()
                    }else if (self.count>24 && self.count<44){
                        let utterance = AVSpeechUtterance(string: phraseSet2[self.count-26])
                        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                        if(speed<0.5){
                            utterance.rate = 0.5
                        }else{
                            utterance.rate = Float(speed)
                        }
                        utterance.volume = self.playvol
                        synthesiser.speak(utterance) // 定型句
                    }else if(self.count==45){
                        self.stop()
                    }
                }else if(mode==1){
                    if(self.count > 0 && self.count < 20)||(self.count>25 && self.count<45){
                        self.scanVoice[23].stop()
                        self.scanVoice[23].play()
                        if(self.count==19){
                            self.count=26
                        }
                    }else{
                        self.stop()
                    }
                }else if(mode==2){
                    if(self.count==20){
                        self.count=25
                    }else if(self.count==45){
                        self.stop()
                    }
                }
            }
        }
    }
    
    // 50音文字盤VOCA画面（清音ひらがな, 清音カタカナ）のオートスキャン開始
    func aiueoStart() {
        self.waiting = false
        self.selected = "aiueo"
        self.cScr = "aiueo"
        self.scanVoice[23].play()  // 最初の効果音
        // タイマー起動
        timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) { _ in
            self.firstCount += 1
            self.scanVoice[23].play()  // 効果音
            // 2周で終了
            if (self.firstCount > 23) {
                self.stop()
                print("終")
            }
        }
    }
    
    // 50音文字盤VOCA画面（(半)濁音ひらがな, (半)濁音カタカナ）のオートスキャン開始
    func gagigugegoStart() {
        self.waiting = false
        self.selected = "gagigugego"
        self.cScr = "gagigugego"
        self.scanVoice[23].play()  // 最初の効果音
        // タイマーを起動
        timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) { _ in
            self.firstCount += 1
            self.scanVoice[23].play()  // 効果音
            // 2周で終了
            if (self.firstCount > 19) {
                self.stop()
                print("終")
            }
        }
    }
    
    // 「定型句」~「消去」ボタンから選択
    func kirikaeToDelete() {
        self.waiting = false
        self.selected = "kirikaeToDelete"
        timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) { _ in
            self.secondCount += 1
            // 2周で終了
            if (self.secondCount > 7) {
                self.stop()
                self.selected = ""
                print("終")
            }
        }
    }
    
    // 行から1文字選択
    func chooseAChara() {
        self.waiting = false
        self.selected = "hitomoji"
        // 選択した行の最初の一文字を再生
        if (self.cScr == "aiueo") {
            let utterance = AVSpeechUtterance(string: self.hiraganaSet[self.line])
            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
            utterance.rate = 0.5
            let synthesiser = AVSpeechSynthesizer()
            synthesiser.speak(utterance)
        } else if (self.cScr == "gagigugego") {
            let utterance = AVSpeechUtterance(string: self.dakuHiraSet[self.line])
            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
            utterance.rate = 0.5
            let synthesiser = AVSpeechSynthesizer()
            synthesiser.speak(utterance)
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) { _ in
            self.secondCount += 1
            // オートスキャン時の読み上げ
            if (self.secondCount < 5) {
                if (self.cScr == "aiueo" && self.secondCount + self.line != 49) {
                    let utterance = AVSpeechUtterance(string: self.hiraganaSet[self.secondCount + self.line])
                    utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                    utterance.rate = 0.5
                    let synthesiser = AVSpeechSynthesizer()
                    synthesiser.speak(utterance)
                } else if (self.cScr == "gagigugego" && self.secondCount + self.line != 39) {
                    let utterance = AVSpeechUtterance(string: self.dakuHiraSet[self.secondCount + self.line])
                    utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                    utterance.rate = 0.5
                    let synthesiser = AVSpeechSynthesizer()
                    synthesiser.speak(utterance)
                }
            } else if (self.secondCount > 4 && self.secondCount < 10 && self.secondCount + self.line - 5 != 49) {
                if (self.cScr == "aiueo") {
                    let utterance = AVSpeechUtterance(string: self.hiraganaSet[self.secondCount + self.line - 5])
                    utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                    utterance.rate = 0.5
                    let synthesiser = AVSpeechSynthesizer()
                    synthesiser.speak(utterance)
                } else if (self.cScr == "gagigugego" && self.secondCount + self.line - 5 != 39) {
                    let utterance = AVSpeechUtterance(string: self.dakuHiraSet[self.secondCount + self.line - 5])
                    utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                    utterance.rate = 0.5
                    let synthesiser = AVSpeechSynthesizer()
                    synthesiser.speak(utterance)
                }
            }
            // 2周で終了
            if (self.secondCount > 9) {
                self.stop()
                print("終")
            }
        }
    }
    
    // 速度・音量から選択
    func speedVolume() {
        self.waiting = false
        self.selected = "speedVolume"
        timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) { _ in
            self.secondCount += 1
            // 2周で終了
            if (self.secondCount > 7) {
                self.stop()
                print("終")
            }
        }
    }
    
    // あ行なら0、か行なら5、た行なら10 ... をlineに代入
    func aLine(x:Int) {
        self.line = (self.firstCount - x) * 5
    }
    
    // オートスキャン終了
    func stop() {
        timer.invalidate()
        self.waiting = true
        self.count = 0
        self.firstCount = 0
        self.secondCount = 0
        self.selected = ""
        
    }
    func stopAudio() {
            audioPlayer?.stop()
            isPlaying = false
        }
    // 減速
    func speedDown(phraseset:[String]) {
        self.speed += 0.2
        // オートスキャン実行中の操作である場合、タイマーを再起動
        if (self.waiting == false) {
            if (self.selected == "") {
                timer.invalidate()
                    timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) { _ in
                    self.count += 1
                    //音声が重なる問題の解決
                    if self.synthesiser.isSpeaking{
                        self.synthesiser.stopSpeaking(at: .immediate)
                        self.isSpeaking=false
                    }
                    // オートスキャン時の読み上げ
                    if (self.count == 25) {
                        self.scanVoice[0].play()  // 「読み上げ」
                    } else if (self.count > 0 && self.count < 19) {

                        let utterance = AVSpeechUtterance(string: phraseset[self.count-1])
                        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                        utterance.volume = self.playvol
                        self.synthesiser.speak(utterance) // 定型句
                    } else if (self.count > 25 && self.count < 44) {
                        let utterance = AVSpeechUtterance(string: phraseset[self.count-26])
                        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                        utterance.volume = self.playvol
                        self.synthesiser.speak(utterance) // 定型句
                    } else if (self.count == 19 || self.count == 44) {
                        self.scanVoice[19].play()  // 「消去」
                    } else if (self.count == 20 || self.count == 45) {
                        self.scanVoice[20].play()  // 「切り替え」
                    } else if (self.count == 21 || self.count == 46) {
                        self.scanVoice[21].play()  // 「早く」
                    } else if (self.count == 22 || self.count == 47) {
                        self.scanVoice[22].play()  // 「遅く」
                    } else if (self.count > 49) {
                        self.stop()  // 2周で終了
                        print("終")
                    }
                }
            } else if (self.selected == "aiueo") {
                timer.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) { _ in
                    self.firstCount += 1
                    self.scanVoice[23].play()  // 効果音
                    // 2周で終了
                    if (self.firstCount > 23) {
                        self.stop()
                        print("終")
                    }
                }
            } else if (self.selected == "gagigugego") {
                timer.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) { _ in
                    self.firstCount += 1
                    self.scanVoice[23].play()  // 効果音
                    // 2周で終了
                    if (self.firstCount > 19) {
                        self.stop()
                        print("終")
                    }
                }
            } else if (self.selected == "kirikaeToDelete" || self.selected == "speedVolume") {
                timer.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) { _ in
                    self.secondCount += 1
                    // 2周で終了
                    if (self.secondCount > 7) {
                        self.stop()
                        print("終")
                    }
                }
            } else if (self.selected == "hitomoji") {
                timer.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) { _ in
                    self.secondCount += 1
                    // オートスキャン時の読み上げ
                    if (self.secondCount < 5) {
                        if (self.cScr == "aiueo" && self.secondCount + self.line != 49) {
                            let utterance = AVSpeechUtterance(string: self.hiraganaSet[self.secondCount + self.line])
                            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                            utterance.rate = 0.5
                            let synthesiser = AVSpeechSynthesizer()
                            synthesiser.speak(utterance)
                        } else if (self.cScr == "gagigugego" && self.secondCount + self.line != 39) {
                            let utterance = AVSpeechUtterance(string: self.dakuHiraSet[self.secondCount + self.line])
                            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                            utterance.rate = 0.5
                            let synthesiser = AVSpeechSynthesizer()
                            synthesiser.speak(utterance)
                        }
                    } else if (self.secondCount > 4 && self.secondCount < 10) {
                        if (self.cScr == "aiueo" && self.secondCount + self.line - 5 != 49) {
                            let utterance = AVSpeechUtterance(string: self.hiraganaSet[self.secondCount + self.line - 5])
                            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                            utterance.rate = 0.5
                            let synthesiser = AVSpeechSynthesizer()
                            synthesiser.speak(utterance)
                        } else if (self.cScr == "gagigugego" && self.secondCount + self.line - 5 != 39) {
                            let utterance = AVSpeechUtterance(string: self.dakuHiraSet[self.secondCount + self.line - 5])
                            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                            utterance.rate = 0.5
                            let synthesiser = AVSpeechSynthesizer()
                            synthesiser.speak(utterance)
                        }
                    }
                    // 2周で終了
                    if (self.secondCount > 9) {
                        self.stop()
                        print("終")
                    }
                }
            }
        }
    }
    
    // 加速
        func speedUp(phraseset:[String]) {
            self.speed -= 0.2
            // オートスキャン実行中の操作である場合、タイマーを再起動
            if (self.waiting == false) {
                if (self.selected == "") {
                    timer.invalidate()
                    timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) { _ in
                        self.count += 1
                        //音声が重なる問題の解決
                        if self.synthesiser.isSpeaking{
                            self.synthesiser.stopSpeaking(at: .immediate)
                            self.isSpeaking=false
                        }
                        // オートスキャン時の読み上げ
                        if (self.count == 25) {
                            self.scanVoice[0].play()  // 「読み上げ」
                        } else if (self.count > 0 && self.count < 19) {
 
                            let utterance = AVSpeechUtterance(string: phraseset[self.count-1])
                            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                            utterance.volume = self.playvol
                            
                            self.synthesiser.speak(utterance) // 定型句
                            
                        } else if (self.count > 25 && self.count < 44) {
                            
                            let utterance = AVSpeechUtterance(string: phraseset[self.count-26])
                            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                            utterance.volume = self.playvol
                            self.synthesiser.speak(utterance) // 定型句
                            
                        } else if (self.count == 19 || self.count == 44) {
                            self.scanVoice[19].play()  // 「消去」
                        } else if (self.count == 20 || self.count == 45) {
                            self.scanVoice[20].play()  // 「切り替え」
                        } else if (self.count == 21 || self.count == 46) {
                            self.scanVoice[21].play()  // 「早く」
                        } else if (self.count == 22 || self.count == 47) {
                            self.scanVoice[22].play()  // 「遅く」
                        }
                        // 2周で終了
                        else if (self.count > 49) {
                            self.stop()
                            print("終")
                        }
                    }
            } else if (self.selected == "aiueo") {
                timer.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) { _ in
                    self.firstCount += 1
                    self.scanVoice[23].play()  // 効果音
                    // 2周で終了
                    if (self.firstCount > 23) {
                        self.stop()
                        print("終")
                    }
                }
            } else if (self.selected == "gagigugego") {
                timer.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) { _ in
                    self.firstCount += 1
                    self.scanVoice[23].play()  // 効果音
                    // 2周で終了
                    if (self.firstCount > 19) {
                        self.stop()
                        print("終")
                    }
                }
            } else if (self.selected == "kirikaeToDelete" || self.selected == "speedVolume") {
                timer.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) { _ in
                    self.secondCount += 1
                    // 2周で終了
                    if (self.secondCount > 7) {
                        self.stop()
                        print("終")
                    }
                }
            } else if (self.selected == "hitomoji") {
                timer.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) { _ in
                    self.secondCount += 1
                    // オートスキャン時の読み上げ
                    if (self.secondCount < 5) {
                        if (self.cScr == "aiueo" && self.secondCount + self.line != 49) {
                            let utterance = AVSpeechUtterance(string: self.hiraganaSet[self.secondCount + self.line])
                            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                            utterance.rate = 0.5
                            let synthesiser = AVSpeechSynthesizer()
                            synthesiser.speak(utterance)
                        } else if (self.cScr == "gagigugego" && self.secondCount + self.line != 39) {
                            let utterance = AVSpeechUtterance(string: self.dakuHiraSet[self.secondCount + self.line])
                            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                            utterance.rate = 0.5
                            let synthesiser = AVSpeechSynthesizer()
                            synthesiser.speak(utterance)
                        }
                    } else if (self.secondCount > 4 && self.secondCount < 10) {
                        if (self.cScr == "aiueo" && self.secondCount + self.line - 5 != 49) {
                            let utterance = AVSpeechUtterance(string: self.hiraganaSet[self.secondCount + self.line - 5])
                            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                            utterance.rate = 0.5
                            let synthesiser = AVSpeechSynthesizer()
                            synthesiser.speak(utterance)
                        } else if (self.cScr == "gagigugego" && self.secondCount + self.line - 5 != 39) {
                            let utterance = AVSpeechUtterance(string: self.dakuHiraSet[self.secondCount + self.line - 5])
                            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                            utterance.rate = 0.5
                            let synthesiser = AVSpeechSynthesizer()
                            synthesiser.speak(utterance)
                        }
                    }
                    // 2周で終了
                    if (self.secondCount > 9) {
                        self.stop()
                        print("終")
                    }
                }
            }
        }
    }
}
