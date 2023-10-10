//
//  voca2App.swift
//  voca2
//
//  Created by GANBAT BATORGIL on 2022/04/06.
//

import SwiftUI

@main
//Thread 1: signal SIGTERMエラーが出る原因はSimulatorを正しく終了していないため（解決：終了するとき[command+Q]）
struct voca2App: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

