import Foundation
import CoreGraphics

/// 지원하는 구기 종목
enum SportType: Int, Codable, CaseIterable, Identifiable {
    case soccer = 0
    case basketball = 1
    case football = 2
    case handball = 3
    case rugby = 4

    var id: Int { rawValue }

    var displayName: String {
        switch self {
        case .soccer: return "축구"
        case .basketball: return "농구"
        case .football: return "미식축구"
        case .handball: return "핸드볼"
        case .rugby: return "럭비"
        }
    }

    /// 필드 논리 크기 (포인트 단위)
    var fieldSize: CGSize {
        switch self {
        case .soccer:     return CGSize(width: 1600, height: 2200)
        case .basketball: return CGSize(width: 850,  height: 1500)
        case .football:   return CGSize(width: 1174, height: 2384)
        case .handball:   return CGSize(width: 1200, height: 2200)
        case .rugby:      return CGSize(width: 1600, height: 2600)
        }
    }

    /// 기본 줌 스케일 (퍼센트)
    var defaultScale: Int {
        switch self {
        case .soccer:     return 60
        case .basketball: return 80
        case .football:   return 70
        case .handball:   return 70
        case .rugby:      return 70
        }
    }

    /// 종목별 기본 선수 수
    var defaultPlayerCount: Int {
        switch self {
        case .soccer:     return 11
        case .basketball: return 5
        case .football:   return 11
        case .handball:   return 7
        case .rugby:      return 15
        }
    }
}
