import SwiftUI

/// 필드 렌더링 프로토콜
protocol FieldRenderer {
    /// 필드를 Canvas GraphicsContext에 렌더링
    func draw(in context: inout GraphicsContext, size: CGSize)
}

/// 종목별 FieldRenderer 팩토리
enum FieldRendererFactory {
    static func renderer(for sport: SportType) -> FieldRenderer {
        switch sport {
        case .soccer:     return SoccerFieldRenderer()
        case .basketball: return BasketballFieldRenderer()
        case .football:   return FootballFieldRenderer()
        case .handball:   return HandballFieldRenderer()
        case .rugby:      return RugbyFieldRenderer()
        }
    }
}

// MARK: - Placeholder Implementations

struct SoccerFieldRenderer: FieldRenderer {
    func draw(in context: inout GraphicsContext, size: CGSize) {
        // 잔디 배경
        context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(Color(red: 0.2, green: 0.6, blue: 0.2)))
        // TODO: 필드 라인, 센터서클, 페널티에어리어 등
    }
}

struct BasketballFieldRenderer: FieldRenderer {
    func draw(in context: inout GraphicsContext, size: CGSize) {
        context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(Color(red: 0.8, green: 0.6, blue: 0.3)))
        // TODO: 농구 코트 라인
    }
}

struct FootballFieldRenderer: FieldRenderer {
    func draw(in context: inout GraphicsContext, size: CGSize) {
        context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(Color(red: 0.2, green: 0.5, blue: 0.2)))
        // TODO: 미식축구 필드 라인, 야드 마킹
    }
}

struct HandballFieldRenderer: FieldRenderer {
    func draw(in context: inout GraphicsContext, size: CGSize) {
        context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(Color(red: 0.3, green: 0.5, blue: 0.7)))
        // TODO: 핸드볼 코트 라인
    }
}

struct RugbyFieldRenderer: FieldRenderer {
    func draw(in context: inout GraphicsContext, size: CGSize) {
        context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(Color(red: 0.2, green: 0.55, blue: 0.2)))
        // TODO: 럭비 필드 라인
    }
}
