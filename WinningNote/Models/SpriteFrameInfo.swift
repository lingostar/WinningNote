import Foundation
import CoreGraphics

/// 프레임별 스프라이트 상태 정보
struct SpriteFrameInfo: Codable, Equatable {
    /// 스프라이트 위치
    var location: CGPoint

    /// 베지어 곡선 제어점
    var controlPoint: CGPoint = .zero

    /// 곡선 이동 여부
    var isCurve: Bool = false

    /// 선 종류
    var lineType: LineType = .solid

    /// 화살표 머리 표시
    var arrowHead: Bool = false
}

/// 이동 경로 선 종류
enum LineType: Int, Codable, CaseIterable, Identifiable {
    case solid = 0    // 실선
    case dash = 1     // 점선
    case zigzag = 2   // 지그재그

    var id: Int { rawValue }

    var displayName: String {
        switch self {
        case .solid:  return "실선"
        case .dash:   return "점선"
        case .zigzag: return "지그재그"
        }
    }
}
