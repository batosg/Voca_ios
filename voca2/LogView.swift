//
//  LogView.swift
//  voca2
//
//  Created by BATORGIL on 2023/10/16.
//

import SwiftUI

struct LogView: View {
    @State private var fileContent: String = ""
    @Binding var screen:String
    var body: some View {
        HStack{
            ScrollView {
                        VStack {
                            Text("File Content:")
                            Text(fileContent)
                                .padding()
                        }
                    }
                    .onAppear {
                        readTextFile()
                    }
                
            Button(action: {
                screen = "option"
               
            }) {
                Text("戻る")
                    .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .black))
                    .foregroundColor(Color(red: 0, green:65/255, blue: 255/255))
                    .frame(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.height * 0.075)
                    .background(Color(red: 200/255, green: 200/255, blue: 203/255))
                    .border(Color.black)
            }
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

