import Foundation
import SwiftUI

/// 스프라이트의 이동 경로(Trail)를 SwiftUI Path로 생성
enum TrailPathBuilder {
    struct TrailPaths {
        var solidPath = Path()
        var dashPath = Path()
        var zigzagPath = Path()
    }

    /// 특정 스프라이트의 Trail 경로 생성
    static func buildTrail<S: SpriteProtocol>(
        for sprite: S,
        currentFrame: Int,
        currentDegree: Float
    ) -> TrailPaths {
        var paths = TrailPaths()

        // 과거 프레임들의 경로
        for i in 1..<currentFrame {
            let startPoint = sprite.location(at: i)
            guard let nextInfo = sprite.frameInfo(at: i + 1) else { continue }
            let endPoint = nextInfo.location

            appendSegment(
                to: &paths,
                from: startPoint,
                to: endPoint,
                frameInfo: nextInfo
            )
        }

        // 현재 진행 중인 애니메이션 경로
        if currentDegree > 0, let nextInfo = sprite.frameInfo(at: currentFrame + 1) {
            let startPoint = sprite.location(at: currentFrame)
            let endPoint = nextInfo.location

            appendPartialSegment(
                to: &paths,
                from: startPoint,
                to: endPoint,
                frameInfo: nextInfo,
                degree: currentDegree
            )
        }

        return paths
    }

    // MARK: - Private

    private static func appendSegment(
        to paths: inout TrailPaths,
        from start: CGPoint,
        to end: CGPoint,
        frameInfo: SpriteFrameInfo
    ) {
        if frameInfo.isCurve {
            let curvePoints = BezierCurve.approximatePoints(
                from: start, to: end, control: frameInfo.controlPoint
            )
            appendToPath(lineType: frameInfo.lineType, paths: &paths, start: start, points: curvePoints)
        } else {
            appendToPath(lineType: frameInfo.lineType, paths: &paths, start: start, points: [end])
        }
    }

    private static func appendPartialSegment(
        to paths: inout TrailPaths,
        from start: CGPoint,
        to end: CGPoint,
        frameInfo: SpriteFrameInfo,
        degree: Float
    ) {
        if frameInfo.isCurve {
            let segments = 30
            let maxSegment = Int(Float(segments) * degree)
            let points = (1...max(1, maxSegment)).map { i in
                let t = CGFloat(i) / CGFloat(segments)
                return BezierCurve.quadratic(from: start, to: end, control: frameInfo.controlPoint, t: t)
            }
            appendToPath(lineType: frameInfo.lineType, paths: &paths, start: start, points: points)
        } else {
            let currentPoint = CGPoint(
                x: start.x + (end.x - start.x) * CGFloat(degree),
                y: start.y + (end.y - start.y) * CGFloat(degree)
            )
            appendToPath(lineType: frameInfo.lineType, paths: &paths, start: start, points: [currentPoint])
        }
    }

    private static func appendToPath(
        lineType: LineType,
        paths: inout TrailPaths,
        start: CGPoint,
        points: [CGPoint]
    ) {
        switch lineType {
        case .solid:
            paths.solidPath.move(to: start)
            for p in points { paths.solidPath.addLine(to: p) }
        case .dash:
            paths.dashPath.move(to: start)
            for p in points { paths.dashPath.addLine(to: p) }
        case .zigzag:
            paths.zigzagPath.move(to: start)
            for p in points { paths.zigzagPath.addLine(to: p) }
        }
    }
}
