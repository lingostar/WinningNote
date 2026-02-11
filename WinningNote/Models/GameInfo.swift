import Foundation
import SwiftUI

/// 경기 기본 정보
struct GameInfo: Codable, Equatable {
    var sport: SportType = .soccer
    var venue: String = ""
    var homeTeamName: String = "Home"
    var visitingTeamName: String = "Away"
    var homeTeamColor: CodableColor = CodableColor(.red)
    var visitingTeamColor: CodableColor = CodableColor(.blue)
}

// MARK: - CodableColor (SwiftUI Color ↔ Codable)

struct CodableColor: Codable, Equatable {
    var red: Double
    var green: Double
    var blue: Double
    var opacity: Double

    init(_ color: Color) {
        // Default fallback
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 1
        #if canImport(AppKit)
        if let nsColor = NSColor(color).usingColorSpace(.deviceRGB) {
            nsColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        }
        #elseif canImport(UIKit)
        UIColor(color).getRed(&r, green: &g, blue: &b, alpha: &a)
        #endif
        self.red = Double(r)
        self.green = Double(g)
        self.blue = Double(b)
        self.opacity = Double(a)
    }

    init(red: Double, green: Double, blue: Double, opacity: Double = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.opacity = opacity
    }

    var color: Color {
        Color(red: red, green: green, blue: blue, opacity: opacity)
    }
}
