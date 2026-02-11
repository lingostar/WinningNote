import SwiftUI

/// 선수 인스펙터 탭
struct PlayerInspectorTab: View {
    @Binding var document: TacticsDocument
    var animationEngine: AnimationEngine

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("선수 인스펙터")
                .font(.headline)

            Text("선수를 선택하면 여기에 선수 정보가 표시됩니다.")
                .font(.caption)
                .foregroundColor(.secondary)

            // TODO: 선택된 선수의 정보 편집
            // - 팀 소속 Picker (홈/원정)
            // - 등번호 입력
            // - 포지션 Picker

            Spacer()
        }
        .padding()
    }
}
