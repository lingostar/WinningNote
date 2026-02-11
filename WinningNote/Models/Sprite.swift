import Foundation
import CoreGraphics
import SwiftUI

// MARK: - Sprite Protocol

/// 스프라이트 공통 프로토콜 (선수, 공)
protocol SpriteProtocol: Identifiable, Codable {
    var id: UUID { get }
    var spriteFrames: [Int: SpriteFrameInfo] { get set }
    var strokeColor: CodableColor { get set }
    var trailColor: CodableColor { get set }
    var isSelected: Bool { get set }
    var trailOn: Bool { get set }

    /// 특정 프레임의 위치
    func location(at frame: Int) -> CGPoint

    /// 특정 프레임의 위치 설정
    mutating func setLocation(_ point: CGPoint, at frame: Int)

    /// 특정 프레임의 SpriteFrameInfo
    func frameInfo(at frame: Int) -> SpriteFrameInfo?

    /// 스프라이트 크기
    var spriteSize: CGFloat { get }

    /// 특정 프레임에서 degree(보간 진행도)에 따른 위치 사각형
    func rect(at frame: Int, degree: Float) -> CGRect
}

extension SpriteProtocol {
    func location(at frame: Int) -> CGPoint {
        let key = max(1, frame)
        return spriteFrames[key]?.location ?? spriteFrames[1]?.location ?? .zero
    }

    mutating func setLocation(_ point: CGPoint, at frame: Int) {
        let key = max(1, frame)
        spriteFrames[key]?.location = point
    }

    func frameInfo(at frame: Int) -> SpriteFrameInfo? {
        let key = max(1, frame)
        return spriteFrames[key]
    }

    func rect(at frame: Int, degree: Float) -> CGRect {
        let startPoint = location(at: frame)
        var resultPoint = startPoint

        if degree > 0, let nextInfo = spriteFrames[frame + 1] {
            let destPoint = nextInfo.location
            if nextInfo.isCurve {
                resultPoint = BezierCurve.quadratic(
                    from: startPoint,
                    to: destPoint,
                    control: nextInfo.controlPoint,
                    t: CGFloat(degree)
                )
            } else {
                let deltaX = (destPoint.x - startPoint.x) * CGFloat(degree)
                let deltaY = (destPoint.y - startPoint.y) * CGFloat(degree)
                resultPoint = CGPoint(x: startPoint.x + deltaX, y: startPoint.y + deltaY)
            }
        }

        let size = spriteSize
        return CGRect(
            x: resultPoint.x - size / 2,
            y: resultPoint.y - size / 2,
            width: size,
            height: size
        )
    }
}
