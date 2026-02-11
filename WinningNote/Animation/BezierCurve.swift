import Foundation
import CoreGraphics

/// 베지어 곡선 유틸리티
enum BezierCurve {
    /// 2차 베지어 곡선 보간
    /// B(t) = (1-t)^2 * P0 + 2(1-t)t * P1 + t^2 * P2
    static func quadratic(from start: CGPoint, to end: CGPoint, control: CGPoint, t: CGFloat) -> CGPoint {
        let t2 = t * t
        let mt = 1 - t
        let mt2 = mt * mt

        let x = start.x * mt2 + 2 * control.x * mt * t + end.x * t2
        let y = start.y * mt2 + 2 * control.y * mt * t + end.y * t2

        return CGPoint(x: x, y: y)
    }

    /// 두 점의 중간점 (기본 제어점 위치)
    static func midpoint(_ p1: CGPoint, _ p2: CGPoint) -> CGPoint {
        CGPoint(x: (p1.x + p2.x) / 2, y: (p1.y + p2.y) / 2)
    }

    /// 베지어 곡선을 근사하는 점 배열 생성
    static func approximatePoints(from start: CGPoint, to end: CGPoint, control: CGPoint, segments: Int = 30) -> [CGPoint] {
        (1...segments).map { i in
            let t = CGFloat(i) / CGFloat(segments)
            return quadratic(from: start, to: end, control: control, t: t)
        }
    }

    /// 벡터 정규화
    static func normalize(_ x: CGFloat, _ y: CGFloat) -> (CGFloat, CGFloat) {
        let length = sqrt(x * x + y * y)
        guard length > 0 else { return (0, 0) }
        return (x / length, y / length)
    }

    /// 두 점 사이의 거리
    static func distance(from p1: CGPoint, to p2: CGPoint) -> CGFloat {
        sqrt(pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2))
    }
}
