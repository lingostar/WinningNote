import Foundation
import CoreGraphics
import SwiftUI

/// 공 스프라이트
struct BallSprite: SpriteProtocol, Equatable {
    static let ballWidth: CGFloat = 20

    var id: UUID = UUID()
    var spriteFrames: [Int: SpriteFrameInfo] = [:]
    var strokeColor: CodableColor = CodableColor(.white)
    var trailColor: CodableColor = CodableColor(red: 0.8, green: 0.5, blue: 0.5)
    var isSelected: Bool = false
    var trailOn: Bool = false

    var spriteSize: CGFloat { Self.ballWidth }

    init(location: CGPoint = CGPoint(x: 100, y: 100)) {
        let initialFrameInfo = SpriteFrameInfo(location: location)
        self.spriteFrames = [1: initialFrameInfo]
    }
}
