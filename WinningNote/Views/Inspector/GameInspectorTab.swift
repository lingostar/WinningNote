import SwiftUI

/// 게임 인스펙터 탭
struct GameInspectorTab: View {
    @Binding var document: TacticsDocument

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 종목 선택
            Section("종목") {
                Picker("종목", selection: $document.data.gameInfo.sport) {
                    ForEach(SportType.allCases) { sport in
                        Text(sport.displayName).tag(sport)
                    }
                }
                .pickerStyle(.menu)
            }

            Divider()

            // 팀 정보
            Section("홈팀") {
                TextField("팀 이름", text: $document.data.gameInfo.homeTeamName)
                    .textFieldStyle(.roundedBorder)
                ColorPicker("팀 색상", selection: Binding(
                    get: { document.data.gameInfo.homeTeamColor.color },
                    set: { document.data.gameInfo.homeTeamColor = CodableColor($0) }
                ))
            }

            Divider()

            Section("원정팀") {
                TextField("팀 이름", text: $document.data.gameInfo.visitingTeamName)
                    .textFieldStyle(.roundedBorder)
                ColorPicker("팀 색상", selection: Binding(
                    get: { document.data.gameInfo.visitingTeamColor.color },
                    set: { document.data.gameInfo.visitingTeamColor = CodableColor($0) }
                ))
            }

            Divider()

            // 경기장
            Section("경기장") {
                TextField("경기장명", text: $document.data.gameInfo.venue)
                    .textFieldStyle(.roundedBorder)
            }

            Spacer()
        }
        .padding()
    }
}
