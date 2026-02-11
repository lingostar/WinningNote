import SwiftUI

/// 프레임 인스펙터 탭
struct FrameInspectorTab: View {
    @Binding var document: TacticsDocument
    var animationEngine: AnimationEngine

    private var currentFrameIndex: Int {
        animationEngine.currentFrameNumber - 1
    }

    private var frameBinding: Binding<AnimationFrame>? {
        guard currentFrameIndex >= 0,
              currentFrameIndex < document.data.frames.count else { return nil }
        return $document.data.frames[currentFrameIndex]
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let frame = frameBinding {
                Section("스케일") {
                    HStack {
                        TextField("Scale", value: frame.scale, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 60)
                        Stepper("", value: frame.scale, in: 10...200, step: 5)
                        Text("%")
                            .foregroundColor(.secondary)
                    }
                }

                Divider()

                Section("타이밍") {
                    HStack {
                        Text("인터벌")
                            .frame(width: 60, alignment: .leading)
                        TextField("sec", value: frame.interval, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 60)
                        Stepper("", value: frame.interval, in: 0.1...10.0, step: 0.1)
                        Text("초")
                            .foregroundColor(.secondary)
                    }

                    HStack {
                        Text("딜레이")
                            .frame(width: 60, alignment: .leading)
                        TextField("sec", value: frame.delay, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 60)
                        Text("초")
                            .foregroundColor(.secondary)
                    }
                }

                Divider()

                Section("포커스") {
                    HStack {
                        Text("X")
                        TextField("X", value: Binding(
                            get: { Double(frame.wrappedValue.focusPoint.x) },
                            set: { frame.wrappedValue.focusPoint.x = CGFloat($0) }
                        ), format: .number)
                            .textFieldStyle(.roundedBorder)
                        Text("Y")
                        TextField("Y", value: Binding(
                            get: { Double(frame.wrappedValue.focusPoint.y) },
                            set: { frame.wrappedValue.focusPoint.y = CGFloat($0) }
                        ), format: .number)
                            .textFieldStyle(.roundedBorder)
                    }
                }

                Divider()

                Section("메모") {
                    TextEditor(text: frame.memo)
                        .frame(minHeight: 60)
                        .border(Color.secondary.opacity(0.3))
                }
            } else {
                Text("프레임 없음")
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding()
    }
}
