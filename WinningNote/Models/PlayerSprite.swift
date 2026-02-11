import Foundation
import CoreGraphics
import SwiftUI

/// 선수 모양
enum PlayerShape: Int, Codable, CaseIterable, Identifiable {
    case circle = 0
    case square = 1

    var id: Int { rawValue }

    var displayName: String {
        switch self {
        case .circle: return "원형"
        case .square: return "사각형"
        }
    }
}

/// 선수 스프라이트
struct PlayerSprite: SpriteProtocol, Equatable {
    static let playerWidth: CGFloat = 36

    var id: UUID = UUID()
    var spriteFrames: [Int: SpriteFrameInfo] = [:]
    var strokeColor: CodableColor = CodableColor(.white)
    var trailColor: CodableColor = CodableColor(.red)
    var isSelected: Bool = false
    var trailOn: Bool = false

    /// 등번호
    var backNumber: String = "0"

    /// 팀 색상
    var playerColor: CodableColor = CodableColor(.red)

    /// 선수 모양
    var shape: PlayerShape = .circle

    /// 원정팀 여부
    var isVisiting: Bool = false

    var spriteSize: CGFloat { Self.playerWidth }

    init(location: CGPoint, isVisiting: Bool = false, teamColor: Color = .red) {
        self.isVisiting = isVisiting
        self.playerColor = CodableColor(teamColor)

        let initialFrameInfo = SpriteFrameInfo(location: location)
        self.spriteFrames = [1: initialFrameInfo]
    }
}
