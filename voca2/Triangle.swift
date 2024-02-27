//
//  Triangle.swift
//  voca2
//
//
//  Created by GANBAT BATORGIL on 2023/04/06.
//

import Foundation
import SwiftUI
import AVFoundation

// 三角形を描画
struct leftTriangle: Shape {
    /// <#Description#>
    /// - Parameter rect: <#rect description#>
    /// - Returns: <#description#>
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}

// 逆三角形を描画
struct rightTriangle: Shape {
    /// <#Description#>
    /// - Parameter rect: <#rect description#>
    /// - Returns: <#description#>
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.closeSubpath()
        }
    }
}
