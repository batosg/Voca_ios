//
//  voca2App.swift
//  voca2
//
//  Created by 髙橋大 on 2022/04/06.
//

import SwiftUI

@main
struct voca2App: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    @State private var phraseSet1: [String] = ["こんにちは", "お腹がすいた", "こっちに来て", "ありがとう", "はい", "いいえ", "あつい", "さむい", "くるしい", "ベッド", "体", "文字盤", "トイレ", "吸引", "テレビ", "上げて", "下げて", "向きを変えて"]
//    @State private var voiceSet1: [String] = ["konnitiwa", "onakasuita", "come", "thanks", "yes", "no", "hot", "cold", "kurusii", "bed", "body", "moziban", "toilet", "kyuuin", "tv", "up", "down", "change"]
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//
//        self.writingToFile_Da(savedata: phraseSet1, savename: "phrarray.dat")
//        self.writingToFile_Da(savedata: voiceSet1, savename: "vcarray.dat")
//
//        return true
//    }
//    // ファイル書き込み（Data）=============================================================
//    func writingToFile_Da(savedata: [String], savename: String) {
//        // DocumentsフォルダURL取得
//        guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            fatalError("フォルダURL取得エラー")
//        }
//        // 対象のファイルURL取得
//        let fileURL = dirURL.appendingPathComponent(savename)
//        // ファイルの書き込み//JSONEncoderを利用
//        do {
//            let encoder = JSONEncoder()
//            let data: Data = try encoder.encode(savedata)
//            try data.write(to: fileURL)
//        } catch {
//            print("Error: \(error)")
//        }
//    }
//    // =================================================================================
//
//    // ファイル読み込み（Data）=============================================================
//    func readFromFile_Da(savename: String) -> [String] { //[String]を返す仕様に変更
//        // DocumentsフォルダURL取得
//        guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            fatalError("フォルダURL取得エラー")
//        }
//        // 対象のファイルURL取得
//        let fileURL = dirURL.appendingPathComponent(savename)
//        // ファイルの読み込み//JSONDecoderを利用
//        do{
//            let fileContents = try Data(contentsOf: fileURL)
//            let read_strings = try JSONDecoder().decode([String].self, from: fileContents)
//            // 読み込んだ内容を戻り値として返す
//            return read_strings
//        }catch{
//            fatalError("ファイル読み込みエラー")
//
//        }
//    }
    // =================================================================================


//}

