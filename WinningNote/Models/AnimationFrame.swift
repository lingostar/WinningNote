import Foundation
import CoreGraphics

/// 키프레임 정보
struct AnimationFrame: Codable, Equatable, Identifiable {
    var id: Int { frameNumber }

    /// 프레임 번호 (1부터 시작)
    var frameNumber: Int

    /// 줌 스케일 (퍼센트, 기본값은 종목별 상이)
    var scale: Int

    /// 이전 프레임 → 현재 프레임 전환 시간 (초)
    var interval: Float = 1.0

    /// 프레임 전환 전 대기 시간 (초)
    var delay: Float = 0.0

    /// 프레임 메모
    var memo: String = ""

    /// 카메라 중심점
    var focusPoint: CGPoint = .zero

    /// 메모 표시 여부
    var showMemo: Bool = false
}
