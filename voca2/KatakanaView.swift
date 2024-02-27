//
//  KatakanaView.swift
//  voca2
//
//  Created by GANBAT BATORGIL on 2023/04/06.
//

import Foundation
import SwiftUI
import AVFoundation

// 50音カタカナ画面
struct katakanaView: View {
    // ContentViewの変数をバインディングする
    @Binding var screen: String
    @Binding var theText: String
    @Binding var playvol: Float
    @State var phraseSet2: [String] = []
    // scanTimerのインスタンスを作り観測する
    @ObservedObject var scan = scanTimer()
    
    var body: some View {
        ZStack {
            Color(red: 191/255, green: 228/255, blue: 255/255).ignoresSafeArea()
            
            VStack {
                HStack {
                    VStack {
                        // 読み上げ切替ボタン
                        Button(action: {
                            print("音声")
                        }) {
                            Text("読み上げ\n\n音声")
                                .font(.system(size: UIScreen.main.bounds.width * 0.02, weight: .medium))
                                .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                .frame(width: UIScreen.main.bounds.width * 0.12, height: UIScreen.main.bounds.height * 0.16)
                                .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                                .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                        }
                        .padding(.bottom)
                        
                        // 設定ボタン
                        Button(action: {
                            screen = "option"
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
                            print("機能あり")  // 未実装
                        }) {
                            Text("スキャン\n範囲\n\n機能あり")
                                .font(.system(size: UIScreen.main.bounds.width * 0.015, weight: .medium))
                                .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                .frame(width: UIScreen.main.bounds.width * 0.12, height: UIScreen.main.bounds.height * 0.16)
                                .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                                .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                        }
                        .padding(.bottom)
                        
                        ZStack {
                            Button(action: {
                                kataScanAction()  // スキャンボタン押下時の処理
                            }) {
                                Text("スキャン")
                                    .font(.system(size: UIScreen.main.bounds.width * 0.017, weight: .medium))
                                    .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                    .frame(width: UIScreen.main.bounds.width * 0.12, height: UIScreen.main.bounds.height * 0.16)
                                    .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                                    .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                            }
                            .keyboardShortcut(.defaultAction)
                            
                            // スキャンボタン
                            Button(action: {
                                kataScanAction()  // スキャンボタン押下時の処理
                            }) {
                                Text("スキャン")
                                    .font(.system(size: UIScreen.main.bounds.width * 0.017, weight: .medium))
                                    .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                    .frame(width: UIScreen.main.bounds.width * 0.12, height: UIScreen.main.bounds.height * 0.16)
                                    .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                                    .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                            }
                            .keyboardShortcut(.space, modifiers: [])
                            
                            // スキャンボタン
                            Button(action: {
                                kataScanAction()  // スキャンボタン押下時の処理
                            }) {
                                Text("スキャン")
                                    .font(.system(size: UIScreen.main.bounds.width * 0.017, weight: .medium))
                                    .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                    .frame(width: UIScreen.main.bounds.width * 0.12, height: UIScreen.main.bounds.height * 0.16)
                                    .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                                    .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                            }
                            .keyboardShortcut("1", modifiers: [])
                            
                            // スキャンボタン
                            Button(action: {
                                kataScanAction()  // スキャンボタン押下時の処理
                            }) {
                                Text("スキャン")
                                    .font(.system(size: UIScreen.main.bounds.width * 0.017, weight: .medium))
                                    .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                    .frame(width: UIScreen.main.bounds.width * 0.12, height: UIScreen.main.bounds.height * 0.16)
                                    .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                                    .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                            }
                            .keyboardShortcut("3", modifiers: [])
                        }
                    }
                }
                .padding(.bottom)
                
                HStack {
                    VStack {
                        // 画面切替ボタン
                        Button(action: {
                            screen = "phrase"  // 定型句VOCAへの遷移
                        }) {
                            Text("定型句")
                                .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                                .foregroundColor(Color.white)
                                .frame(width: UIScreen.main.bounds.width * 0.13, height: UIScreen.main.bounds.height * 0.09)
                                .background(Color(red: 3/255, green: 175/255, blue: 122/255))
                                .border(((scan.secondCount == 0 || scan.secondCount == 4) && scan.selected == "kirikaeToDelete") ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: (((scan.secondCount == 0 || scan.secondCount == 4) && scan.selected == "kirikaeToDelete") ? 10 : 1)) // オートスキャン
                        }
                        
                        // 文字盤切替ボタン
                        Button(action:{
                            screen = "dakuKata"  // 50音文字盤（(半)濁音ひらがな）への遷移
                        }) {
                            Text("かな/カナ")
                                .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                                .foregroundColor(Color.white)
                                .frame(width: UIScreen.main.bounds.width * 0.13, height: UIScreen.main.bounds.height * 0.09)
                                .background(Color(red: 3/255, green: 175/255, blue: 122/255))
                                .border(((scan.secondCount == 1 || scan.secondCount == 5) && scan.selected == "kirikaeToDelete") ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: (((scan.secondCount == 1 || scan.secondCount == 5) && scan.selected == "kirikaeToDelete") ? 10 : 1)) // オートスキャン
                        }
                        
                        // 読み上げボタン
                        Button(action: {
                            let utterance = AVSpeechUtterance(string: theText)
                            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                            utterance.rate = 0.5
                            utterance.volume = playvol
                            let synthesiser = AVSpeechSynthesizer()
                            synthesiser.speak(utterance)
                        }) {
                            Text("読み上げ")
                                .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                                .foregroundColor(Color.white)
                                .frame(width: UIScreen.main.bounds.width * 0.13, height: UIScreen.main.bounds.height * 0.09)
                                .background(Color(red: 3/255, green: 175/255, blue: 122/255))
                                .border(((scan.secondCount == 2 || scan.secondCount == 6) && scan.selected == "kirikaeToDelete") ? Color(red: 0, green: 90/255, blue: 255/255) : Color.black, width: (((scan.secondCount == 2 || scan.secondCount == 6) && scan.selected == "kirikaeToDelete") ? 10 : 1))
                        }
                        
                        // 消去ボタン
                        Button(action: {
                            theText = ""
                        }) {
                            Text("消去")
                                .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                                .foregroundColor(Color.white)
                                .frame(width: UIScreen.main.bounds.width * 0.13, height: UIScreen.main.bounds.height * 0.09)
                                .background(Color(red: 255/255, green: 75/255, blue: 0))
                                .border(((scan.secondCount == 3 || scan.secondCount == 7) && scan.selected == "kirikaeToDelete") ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: (((scan.secondCount == 3 || scan.secondCount == 7) && scan.selected == "kirikaeToDelete") ? 10 : 1)) // オートスキャン
                        }
                    }
                    // 行ごとのオートスキャンで現れる枠
                    .border(Color(red: 0, green: 90/255, blue: 255/255), width: (((scan.firstCount == 0 || scan.firstCount == 12) && scan.selected == "aiueo") ? 5 : 0))
                    
                    Group {
                        VStack {
                            // ア行の50音ボタン
                            ForEach(0..<5) { index in
                                Button(action: {
                                    theText += "\(scan.katakanaSet[index])"
                                    // 読み上げ
                                    let utterance = AVSpeechUtterance(string: scan.katakanaSet[index])
                                    utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                                    utterance.rate = 0.5
                                    utterance.volume = playvol
                                    let synthesiser = AVSpeechSynthesizer()
                                    synthesiser.speak(utterance)
                                }) {
                                    Text("\(scan.katakanaSet[index]) ")
                                        .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                                        .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                        .frame(width: UIScreen.main.bounds.height * 0.08, height: UIScreen.main.bounds.height * 0.08)
                                    // 行選択後の一文字ずつのオートスキャンで太さと色が変わる枠
                                        .border(((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 0) ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: (((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 0) ? 10 : 1)) // オートスキャン
                                        .background(Color.white)
                                }
                            }
                        }
                        // 行ごとのオートスキャンで現れる枠
                        .border(Color(red: 0, green: 90/255, blue: 255/255), width: (((scan.firstCount == 1 || scan.firstCount == 13) && scan.selected == "aiueo") ? 5 : 0))
                        
                        VStack {
                            // カ行の50音ボタン
                            ForEach(5..<10) { index in
                                Button(action: {
                                    theText += "\(scan.katakanaSet[index])"
                                    // 読み上げ
                                    let utterance = AVSpeechUtterance(string: scan.katakanaSet[index])
                                    utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                                    utterance.rate = 0.5
                                    utterance.volume = playvol
                                    let synthesiser = AVSpeechSynthesizer()
                                    synthesiser.speak(utterance)
                                }) {
                                    Text("\(scan.katakanaSet[index]) ")
                                        .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                                        .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                        .frame(width: UIScreen.main.bounds.height * 0.08, height: UIScreen.main.bounds.height * 0.08)
                                    // 行選択後の一文字ずつのオートスキャンで太さと色が変わる枠
                                        .border(((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 5) ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: (((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 5) ? 10 : 1)) // オートスキャン
                                        .background(Color.white)
                                }
                            }
                        }
                        // 行ごとのオートスキャンで現れる枠
                        .border(Color(red: 0, green: 90/255, blue: 255/255), width: (((scan.firstCount == 2 || scan.firstCount == 14) && scan.selected == "aiueo") ? 5 : 0))
                        
                        VStack {
                            // サ行の50音ボタン
                            ForEach(10..<15) { index in
                                Button(action: {
                                    theText += "\(scan.katakanaSet[index])"
                                    // 読み上げ
                                    let utterance = AVSpeechUtterance(string: scan.katakanaSet[index])
                                    utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                                    utterance.rate = 0.5
                                    utterance.volume = playvol
                                    let synthesiser = AVSpeechSynthesizer()
                                    synthesiser.speak(utterance)
                                }) {
                                    Text("\(scan.katakanaSet[index]) ")
                                        .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                                        .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                        .frame(width: UIScreen.main.bounds.height * 0.08, height: UIScreen.main.bounds.height * 0.08)
                                    // 行選択後の一文字ずつのオートスキャンで太さと色が変わる枠
                                        .border(((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 10) ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: (((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 10) ? 10 : 1)) // オートスキャン
                                        .background(Color.white)
                                }
                            }
                        }
                        // 行ごとのオートスキャンで現れる枠
                        .border(Color(red: 0, green: 90/255, blue: 255/255), width: (((scan.firstCount == 3 || scan.firstCount == 15) && scan.selected == "aiueo") ? 5 : 0))
                    }
                    
                    Group {
                        VStack {
                            // タ行の50音ボタン
                            ForEach(15..<20) { index in
                                Button(action: {
                                    theText += "\(scan.katakanaSet[index])"
                                    // 読み上げ
                                    let utterance = AVSpeechUtterance(string: scan.katakanaSet[index])
                                    utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                                    utterance.rate = 0.5
                                    utterance.volume = playvol
                                    let synthesiser = AVSpeechSynthesizer()
                                    synthesiser.speak(utterance)
                                }) {
                                    Text("\(scan.katakanaSet[index])")
                                        .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                                        .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                        .frame(width: UIScreen.main.bounds.height * 0.08, height: UIScreen.main.bounds.height * 0.08)
                                    // 行選択後の一文字ずつのオートスキャンで太さと色が変わる枠
                                        .border(((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 15) ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: (((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 15) ? 10 : 1)) // オートスキャン
                                        .background(Color.white)
                                }
                            }
                        }
                        // 行ごとのオートスキャンで現れる枠
                        .border(Color(red: 0, green: 90/255, blue: 255/255), width: (((scan.firstCount == 4 || scan.firstCount == 16) && scan.selected == "aiueo") ? 5 : 0))
                        
                        VStack {
                            // ナ行の50音ボタン
                            ForEach(20..<25) { index in
                                Button(action: {
                                    theText += "\(scan.katakanaSet[index])"
                                    // 読み上げ
                                    let utterance = AVSpeechUtterance(string: scan.katakanaSet[index])
                                    utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                                    utterance.rate = 0.5
                                    utterance.volume = playvol
                                    let synthesiser = AVSpeechSynthesizer()
                                    synthesiser.speak(utterance)
                                }) {
                                    Text("\(scan.katakanaSet[index])")
                                        .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                                        .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                        .frame(width: UIScreen.main.bounds.height * 0.08, height: UIScreen.main.bounds.height * 0.08)
                                    // 行選択後の一文字ずつのオートスキャンで太さと色が変わる枠
                                        .border(((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 20) ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: (((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 20) ? 10 : 1)) // オートスキャン
                                        .background(Color.white)
                                }
                            }
                        }
                        // 行ごとのオートスキャンで現れる枠
                        .border(Color(red: 0, green: 90/255, blue: 255/255), width: (((scan.firstCount == 5 || scan.firstCount == 17) && scan.selected == "aiueo") ? 5 : 0))
                        
                        VStack {
                            // ハ行の50音ボタン
                            ForEach(25..<30) { index in
                                Button(action: {
                                    theText += "\(scan.katakanaSet[index])"
                                    // 読み上げ
                                    let utterance = AVSpeechUtterance(string: scan.katakanaSet[index])
                                    utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                                    utterance.rate = 0.5
                                    utterance.volume = playvol
                                    let synthesiser = AVSpeechSynthesizer()
                                    synthesiser.speak(utterance)
                                }) {
                                    Text("\(scan.katakanaSet[index])")
                                        .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                                        .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                        .frame(width: UIScreen.main.bounds.height * 0.08, height: UIScreen.main.bounds.height * 0.08)
                                    // 行選択後の一文字ずつのオートスキャンで太さと色が変わる枠
                                        .border(((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 25) ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: (((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 25) ? 10 : 1)) // オートスキャン
                                        .background(Color.white)
                                }
                            }
                        }
                        // 行ごとのオートスキャンで現れる枠
                        .border(Color(red: 0, green: 90/255, blue: 255/255), width: (((scan.firstCount == 6 || scan.firstCount == 18) && scan.selected == "aiueo") ? 5 : 0))
                    }
                    
                    Group {
                        VStack {
                            // マ行の50音ボタン
                            ForEach(30..<35) { index in
                                Button(action: {
                                    theText += "\(scan.katakanaSet[index])"
                                    // 読み上げ
                                    let utterance = AVSpeechUtterance(string: scan.katakanaSet[index])
                                    utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                                    utterance.rate = 0.5
                                    utterance.volume = playvol
                                    let synthesiser = AVSpeechSynthesizer()
                                    synthesiser.speak(utterance)
                                }) {
                                    Text("\(scan.katakanaSet[index])")
                                        .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                                        .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                        .frame(width: UIScreen.main.bounds.height * 0.08, height: UIScreen.main.bounds.height * 0.08)
                                    // 行選択後の一文字ずつのオートスキャンで太さと色が変わる枠
                                        .border(((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 30) ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: (((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 30) ? 10 : 1)) // オートスキャン
                                        .background(Color.white)
                                }
                            }
                        }
                        // 行ごとのオートスキャンで現れる枠
                        .border(Color(red: 0, green: 90/255, blue: 255/255), width: (((scan.firstCount == 7 || scan.firstCount == 19) && scan.selected == "aiueo") ? 5 : 0))
                        
                        VStack {
                            // ヤ行の50音ボタン
                            ForEach(35..<40) { index in
                                Button(action: {
                                    theText += "\(scan.katakanaSet[index])"
                                    // 読み上げ
                                    let utterance = AVSpeechUtterance(string: scan.katakanaSet[index])
                                    utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                                    utterance.rate = 0.5
                                    utterance.volume = playvol
                                    let synthesiser = AVSpeechSynthesizer()
                                    synthesiser.speak(utterance)
                                }) {
                                    Text("\(scan.katakanaSet[index])")
                                        .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                                        .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                        .frame(width: UIScreen.main.bounds.height * 0.08, height: UIScreen.main.bounds.height * 0.08)
                                    // 行選択後の一文字ずつのオートスキャンで太さと色が変わる枠
                                        .border(((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 35) ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: (((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 35) ? 10 : 1)) // オートスキャン
                                        .background(Color.white)
                                }
                            }
                        }
                        // 行ごとのオートスキャンで現れる枠
                        .border(Color(red: 0, green: 90/255, blue: 255/255), width: (((scan.firstCount == 8 || scan.firstCount == 20) && scan.selected == "aiueo") ? 5 : 0))
                        
                        VStack {
                            // ラ行の50音ボタン
                            ForEach(40..<45) { index in
                                Button(action: {
                                    theText += "\(scan.katakanaSet[index])"
                                    // 読み上げ
                                    let utterance = AVSpeechUtterance(string: scan.katakanaSet[index])
                                    utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                                    utterance.rate = 0.5
                                    utterance.volume = playvol
                                    let synthesiser = AVSpeechSynthesizer()
                                    synthesiser.speak(utterance)
                                }) {
                                    Text("\(scan.katakanaSet[index])")
                                        .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                                        .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                        .frame(width: UIScreen.main.bounds.height * 0.08, height: UIScreen.main.bounds.height * 0.08)
                                    // 行選択後の一文字ずつのオートスキャンで太さと色が変わる枠
                                        .border(((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 40) ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: (((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 40) ? 10 : 1)) // オートスキャン
                                        .background(Color.white)
                                }
                            }
                        }
                        // 行ごとのオートスキャンで現れる枠
                        .border(Color(red: 0, green: 90/255, blue: 255/255), width: (((scan.firstCount == 9 || scan.firstCount == 21) && scan.selected == "aiueo") ? 5 : 0))
                        
                        VStack {
                            // ワ行の50音ボタン
                            ForEach(45..<49) { index in
                                Button(action: {
                                    theText += "\(scan.katakanaSet[index])"
                                    // 読み上げ
                                    let utterance = AVSpeechUtterance(string: scan.katakanaSet[index])
                                    utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                                    utterance.rate = 0.5
                                    utterance.volume = playvol
                                    let synthesiser = AVSpeechSynthesizer()
                                    synthesiser.speak(utterance)
                                }) {
                                    Text("\(scan.katakanaSet[index])")
                                        .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                                        .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                        .frame(width: UIScreen.main.bounds.height * 0.08, height: UIScreen.main.bounds.height * 0.08)
                                    // 行選択後の一文字ずつのオートスキャンで太さと色が変わる枠
                                        .border(((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 45) ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: (((scan.secondCount + scan.line == index || scan.secondCount + scan.line == index + 5) && scan.selected == "hitomoji" && scan.line == 45) ? 10 : 1)) // オートスキャン
                                        .background(Color.white)
                                }
                            }
                            
                            // 一文字消しボタン
                            Button(action: {
                                theText = String(theText.dropLast())
                            }) {
                                Text("消")
                                    .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .bold))
                                    .foregroundColor(Color(red: 0, green: 65/255, blue: 255/255))
                                    .frame(width: UIScreen.main.bounds.height * 0.08, height: UIScreen.main.bounds.height * 0.08)
                                // 行選択後の一つずつのオートスキャンで太さと色が変わる枠
                                    .border(((scan.secondCount + scan.line == 49 || scan.secondCount + scan.line == 54) && scan.selected == "hitomoji" && scan.line == 45) ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: (((scan.secondCount + scan.line == 49 || scan.secondCount + scan.line == 54) && scan.selected == "hitomoji" && scan.line == 45) ? 10 : 1)) // オートスキャン
                                    .background(Color.white)
                            }
                        }
                        // 行ごとのオートスキャンで現れる枠
                        .border(Color(red: 0, green: 90/255, blue: 255/255), width: (((scan.firstCount == 10 || scan.firstCount == 22) && scan.selected == "aiueo") ? 5 : 0))
                    }
                    
                    VStack {
                        Text("速度").font(.system(size: UIScreen.main.bounds.width * 0.02))
                        
                        // 速度変更ボタン（加速）
                        HStack {
                            ZStack {
                                Button(action: {
                                    if (scan.speed > 0.3) {
                                        scan.speedUp(phraseset: phraseSet2) // 加速
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
                                // 枠のみの三角形（オートスキャンで太さと色が変わる）
                                leftTriangle()
                                    .stroke(((scan.secondCount == 0 || scan.secondCount == 4) && scan.waiting == false && scan.selected == "speedVolume") ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, lineWidth: (((scan.secondCount == 0 || scan.secondCount == 4) && scan.waiting == false && scan.selected == "speedVolume") ? 10 : 1))
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
                            
                            // 速度変更ボタン（減速）
                            ZStack {
                                Button(action: {
                                    if (scan.speed < 1.9) {
                                        scan.speedDown(phraseset: phraseSet2) // 減速
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
                                // 枠のみの三角形（オートスキャンで太さと色が変わる）
                                rightTriangle()
                                    .stroke(((scan.secondCount == 1 || scan.secondCount == 5) && scan.waiting == false && scan.selected == "speedVolume") ? Color(red: 0, green: 90/255, blue: 255/255) : Color.black, lineWidth: (((scan.secondCount == 1 || scan.secondCount == 5) && scan.waiting == false && scan.selected == "speedVolume") ? 10 : 1))
                                    .frame(width: UIScreen.main.bounds.height * 0.06, height: UIScreen.main.bounds.height * 0.08)
                            }
                        }
                        .padding(.bottom)
                        
                        Text("音量").font(.system(size: UIScreen.main.bounds.width * 0.02))
                        
                        // 音量変更ボタン（-）
                        HStack {
                            ZStack {
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
                                // 枠のみの三角形（オートスキャンで太さと色が変わる）
                                leftTriangle()
                                    .stroke(((scan.secondCount == 2 || scan.secondCount == 6) && scan.waiting == false && scan.selected == "speedVolume") ? Color(red: 0, green: 90/255, blue: 255/255) : /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, lineWidth: (((scan.secondCount == 2 || scan.secondCount == 6) && scan.waiting == false && scan.selected == "speedVolume") ? 10 : 1))
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
                            
                            // 音量変更ボタン（+）
                            ZStack {
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
                                // 枠のみの三角形（オートスキャンで太さと色が変わる）
                                rightTriangle()
                                    .stroke(((scan.secondCount == 3 || scan.secondCount == 7) && scan.waiting == false && scan.selected == "speedVolume") ? Color(red: 0, green: 90/255, blue: 255/255) : Color.black, lineWidth: (((scan.secondCount == 3 || scan.secondCount == 7) && scan.waiting == false && scan.selected == "speedVolume") ? 10 : 1))
                                    .frame(width: UIScreen.main.bounds.height * 0.06, height: UIScreen.main.bounds.height * 0.08)
                            }
                        }
                    }
                    // 行ごとのオートスキャンで現れる枠
                    .border(Color(red: 0, green: 90/255, blue: 255/255), width: (((scan.firstCount == 11 || scan.firstCount == 23) && scan.selected == "aiueo") ? 5 : 0))
                }
            }
        }
    }
    
    // スキャンボタン押下時の処理
    func kataScanAction() {
        if (screen == "katakana") {
            if scan.waiting {
                scan.aiueoStart() // オートスキャン開始
            } else {
                if (scan.selected == "aiueo") {
                    // オートスキャンによるボタン選択
                    if (scan.firstCount == 0 || scan.firstCount == 12) {
                        scan.stop() // オートスキャン再起動のため一旦終了
                        scan.kirikaeToDelete()  // 「定型句」~「消去」ボタンから選択のオートスキャン開始
                    } else if (scan.firstCount >= 1 && scan.firstCount <= 10) {
                        scan.aLine(x: 1)
                        scan.stop() // オートスキャン再起動のため一旦終了
                        scan.chooseAChara()  // 行から1文字選択のオートスキャン開始
                    } else if (scan.firstCount >= 13 && scan.secondCount <= 22) {
                        scan.aLine(x: 13)
                        scan.stop() // オートスキャン再起動のため一旦終了
                        scan.chooseAChara()  // 行から1文字選択のオートスキャン開始
                    } else if (scan.firstCount == 11 || scan.firstCount == 23) {
                        scan.stop() // オートスキャン再起動のため一旦終了
                        scan.speedVolume()  // 速度・音量選択のオートスキャン開始
                    }
                } else {
                    if (scan.selected == "kirikaeToDelete") {
                        if (scan.secondCount == 0 || scan.secondCount == 4) {
                            screen = "phrase"  // 定型句VOCAへの遷移
                            scan.stop()  // オートスキャン終了
                        } else if (scan.secondCount == 1 || scan.secondCount == 5) {
                            screen = "dakuKata"  // 50音文字盤（(半)濁音カタカナ）への遷移
                            scan.stop()  // オートスキャン終了
                        } else if (scan.secondCount == 2 || scan.secondCount == 6) {
                            let utterance = AVSpeechUtterance(string: theText)
                            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                            utterance.rate = 0.5
                            let synthesiser = AVSpeechSynthesizer()
                            synthesiser.speak(utterance)
                            scan.stop()  // オートスキャン終了
                        } else if (scan.secondCount == 3 || scan.secondCount == 7) {
                            theText = ""
                            scan.stop()  // オートスキャン終了
                        }
                    } else if (scan.selected == "hitomoji") {
                        if (scan.secondCount >= 0 && scan.secondCount <= 4 && scan.secondCount + scan.line != 49) {
                            theText += "\(scan.katakanaSet[scan.secondCount + scan.line])"
                            // 選択時の音声
                            let utterance = AVSpeechUtterance(string: scan.katakanaSet[scan.secondCount + scan.line])
                            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                            utterance.rate = 0.5
                            let synthesiser = AVSpeechSynthesizer()
                            synthesiser.speak(utterance)
                            scan.stop()  // オートスキャン終了
                        } else if (scan.secondCount >= 5 && scan.secondCount <= 9 && scan.secondCount - 5 + scan.line != 49) {
                            theText += "\(scan.katakanaSet[scan.secondCount - 5 + scan.line])"
                            // 選択時の音声
                            let utterance = AVSpeechUtterance(string: scan.katakanaSet[scan.secondCount - 5 + scan.line])
                            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                            utterance.rate = 0.5
                            let synthesiser = AVSpeechSynthesizer()
                            synthesiser.speak(utterance)
                            scan.stop()  // オートスキャン終了
                        } else if (scan.line == 45 && (scan.secondCount == 4 || scan.secondCount == 9)) {
                            theText = String(theText.dropLast())  // 一文字消す
                            scan.stop()  // オートスキャン終了
                        }
                    } else if (scan.selected == "speedVolume") {
                        if (scan.secondCount == 0 || scan.secondCount == 4) {
                            scan.speedDown(phraseset: phraseSet2)  // 減速
                            scan.stop()  // オートスキャン終了
                        } else if (scan.secondCount == 1 || scan.secondCount == 5) {
                            scan.speedUp(phraseset: phraseSet2)  // 加速
                            scan.stop()  // オートスキャン終了
                        } else if (scan.secondCount == 2 || scan.secondCount == 6) {
                            playvol -= 0.1  // 音量減
                            scan.stop()  // オートスキャン終了
                        } else if (scan.secondCount == 3 || scan.secondCount == 7) {
                            playvol += 0.1  // 音量増
                            scan.stop()  // オートスキャン終了
                        }
                    }
                }
            }
        }
    }
}
