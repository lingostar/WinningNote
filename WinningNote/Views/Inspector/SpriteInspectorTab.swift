import SwiftUI

/// 스프라이트 인스펙터 탭
struct SpriteInspectorTab: View {
    @Binding var document: TacticsDocument
    var animationEngine: AnimationEngine

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("스프라이트 인스펙터")
                .font(.headline)

            Text("선수나 공을 선택하면 여기에 속성이 표시됩니다.")
                .font(.caption)
                .foregroundColor(.secondary)

            // TODO: 선택된 스프라이트의 속성 편집
            // - 위치 (X, Y)
            // - 곡선 이동 토글
            // - 제어점 (X, Y)
            // - 선 종류 Picker
            // - 화살표 머리 Toggle
            // - Trail 표시 Toggle
            // - 모양 Picker (선수만)
            // - 색상 ColorPicker (선수만)

            Spacer()
        }
        .padding()
    }
}
