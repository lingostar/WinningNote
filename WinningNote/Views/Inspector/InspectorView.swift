import SwiftUI

/// 인스펙터 탭 종류
enum InspectorTab: String, CaseIterable, Identifiable {
    case game = "Game"
    case frame = "Frame"
    case sprite = "Sprite"
    case player = "Player"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .game:   return "sportscourt"
        case .frame:  return "film"
        case .sprite: return "arrow.up.right.and.arrow.down.left"
        case .player: return "person.fill"
        }
    }

    var label: String {
        switch self {
        case .game:   return "게임"
        case .frame:  return "프레임"
        case .sprite: return "스프라이트"
        case .player: return "선수"
        }
    }
}

/// 인스펙터 사이드바
struct InspectorView: View {
    @Binding var document: TacticsDocument
    var animationEngine: AnimationEngine
    @State private var selectedTab: InspectorTab = .frame

    var body: some View {
        VStack(spacing: 0) {
            // 탭 선택
            Picker("Inspector", selection: $selectedTab) {
                ForEach(InspectorTab.allCases) { tab in
                    Image(systemName: tab.icon)
                        .help(tab.label)
                        .tag(tab)
                }
            }
            .pickerStyle(.segmented)
            .padding(8)

            Divider()

            // 탭 내용
            ScrollView {
                switch selectedTab {
                case .game:
                    GameInspectorTab(document: $document)
                case .frame:
                    FrameInspectorTab(document: $document, animationEngine: animationEngine)
                case .sprite:
                    SpriteInspectorTab(document: $document, animationEngine: animationEngine)
                case .player:
                    PlayerInspectorTab(document: $document, animationEngine: animationEngine)
                }
            }
        }
        .background(.ultraThinMaterial)
    }
}
