import Foundation
import CoreGraphics

/// 포메이션 프리셋 데이터
enum FormationPresets {
    struct Formation: Identifiable {
        let id = UUID()
        let name: String
        let positions: [CGPoint]
    }

    // MARK: - 축구 포메이션 (홈팀, 필드 하단 → 상단)

    static let soccerHome: [Formation] = [
        Formation(name: "3-5-2", positions: [
            CGPoint(x: 800, y: 125),
            CGPoint(x: 400, y: 500), CGPoint(x: 800, y: 500), CGPoint(x: 1200, y: 500),
            CGPoint(x: 580, y: 800), CGPoint(x: 1020, y: 800),
            CGPoint(x: 250, y: 1050), CGPoint(x: 1350, y: 1050),
            CGPoint(x: 800, y: 1400),
            CGPoint(x: 540, y: 1650), CGPoint(x: 1060, y: 1650)
        ]),
        Formation(name: "3-4-3", positions: [
            CGPoint(x: 800, y: 125),
            CGPoint(x: 400, y: 500), CGPoint(x: 800, y: 500), CGPoint(x: 1200, y: 500),
            CGPoint(x: 580, y: 800), CGPoint(x: 1020, y: 800),
            CGPoint(x: 250, y: 1050), CGPoint(x: 1350, y: 1050),
            CGPoint(x: 1060, y: 1400), CGPoint(x: 540, y: 1400),
            CGPoint(x: 800, y: 1650)
        ]),
        Formation(name: "4-4-2", positions: [
            CGPoint(x: 800, y: 125),
            CGPoint(x: 200, y: 500), CGPoint(x: 580, y: 450), CGPoint(x: 1020, y: 450), CGPoint(x: 1400, y: 500),
            CGPoint(x: 200, y: 1250), CGPoint(x: 580, y: 1150), CGPoint(x: 1020, y: 1150), CGPoint(x: 1400, y: 1250),
            CGPoint(x: 540, y: 1650), CGPoint(x: 1060, y: 1650)
        ]),
        Formation(name: "4-3-3", positions: [
            CGPoint(x: 800, y: 125),
            CGPoint(x: 200, y: 500), CGPoint(x: 580, y: 450), CGPoint(x: 1020, y: 450), CGPoint(x: 1400, y: 500),
            CGPoint(x: 400, y: 1050), CGPoint(x: 800, y: 1200), CGPoint(x: 1200, y: 1050),
            CGPoint(x: 400, y: 1600), CGPoint(x: 1200, y: 1600), CGPoint(x: 800, y: 1650)
        ]),
        Formation(name: "4-2-3-1", positions: [
            CGPoint(x: 800, y: 125),
            CGPoint(x: 200, y: 500), CGPoint(x: 580, y: 450), CGPoint(x: 1020, y: 450), CGPoint(x: 1400, y: 500),
            CGPoint(x: 450, y: 900), CGPoint(x: 1150, y: 900),
            CGPoint(x: 800, y: 1200), CGPoint(x: 400, y: 1400), CGPoint(x: 1200, y: 1400),
            CGPoint(x: 800, y: 1650)
        ])
    ]

    // MARK: - 축구 포메이션 (원정팀, 필드 상단 → 하단)

    static let soccerVisiting: [Formation] = [
        Formation(name: "3-5-2", positions: [
            CGPoint(x: 800, y: 2075),
            CGPoint(x: 400, y: 1700), CGPoint(x: 800, y: 1700), CGPoint(x: 1200, y: 1700),
            CGPoint(x: 580, y: 1450), CGPoint(x: 1020, y: 1450),
            CGPoint(x: 250, y: 1150), CGPoint(x: 1350, y: 1150),
            CGPoint(x: 800, y: 850),
            CGPoint(x: 540, y: 550), CGPoint(x: 1060, y: 550)
        ]),
        Formation(name: "3-4-3", positions: [
            CGPoint(x: 800, y: 2075),
            CGPoint(x: 400, y: 1700), CGPoint(x: 800, y: 1700), CGPoint(x: 1200, y: 1700),
            CGPoint(x: 580, y: 1450), CGPoint(x: 1020, y: 1450),
            CGPoint(x: 250, y: 1150), CGPoint(x: 1350, y: 1150),
            CGPoint(x: 800, y: 550), CGPoint(x: 540, y: 850), CGPoint(x: 1060, y: 850)
        ]),
        Formation(name: "4-4-2", positions: [
            CGPoint(x: 800, y: 2075),
            CGPoint(x: 200, y: 1700), CGPoint(x: 580, y: 1750), CGPoint(x: 1020, y: 1750), CGPoint(x: 1400, y: 1700),
            CGPoint(x: 200, y: 1000), CGPoint(x: 580, y: 1050), CGPoint(x: 1020, y: 1050), CGPoint(x: 1400, y: 1000),
            CGPoint(x: 540, y: 550), CGPoint(x: 1060, y: 550)
        ]),
        Formation(name: "4-3-3", positions: [
            CGPoint(x: 800, y: 2075),
            CGPoint(x: 200, y: 1700), CGPoint(x: 580, y: 1750), CGPoint(x: 1020, y: 1750), CGPoint(x: 1400, y: 1750),
            CGPoint(x: 400, y: 1150), CGPoint(x: 800, y: 1000), CGPoint(x: 1200, y: 1150),
            CGPoint(x: 400, y: 600), CGPoint(x: 1200, y: 600), CGPoint(x: 800, y: 550)
        ]),
        Formation(name: "4-2-3-1", positions: [
            CGPoint(x: 800, y: 2075),
            CGPoint(x: 200, y: 1700), CGPoint(x: 580, y: 1750), CGPoint(x: 1020, y: 1750), CGPoint(x: 1400, y: 1700),
            CGPoint(x: 800, y: 1000), CGPoint(x: 1150, y: 1300),
            CGPoint(x: 450, y: 1300), CGPoint(x: 400, y: 800), CGPoint(x: 1200, y: 800),
            CGPoint(x: 800, y: 550)
        ])
    ]
}
