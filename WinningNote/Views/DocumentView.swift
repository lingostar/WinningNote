import SwiftUI

/// 메인 도큐먼트 편집 뷰
struct DocumentView: View {
    @Binding var document: TacticsDocument
    @State private var animationEngine = AnimationEngine()
    @State private var showInspector = true

    var body: some View {
        HSplitView {
            // 메인 캔버스 영역
            VStack(spacing: 0) {
                // 필드 캔버스
                FieldCanvasView(
                    document: $document,
                    animationEngine: animationEngine
                )

                Divider()

                // 타임라인 + 재생 컨트롤
                PlaybackControlView(
                    document: $document,
                    animationEngine: animationEngine
                )
                .frame(height: 60)
                .padding(.horizontal)
            }

            // 인스펙터 사이드바
            if showInspector {
                InspectorView(
                    document: $document,
                    animationEngine: animationEngine
                )
                .frame(minWidth: 260, idealWidth: 280, maxWidth: 320)
            }
        }
        .toolbar {
            ToolbarItemGroup {
                Button {
                    showInspector.toggle()
                } label: {
                    Image(systemName: "sidebar.trailing")
                }
                .help("인스펙터 토글")
            }
        }
    }
}
