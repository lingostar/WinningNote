import SwiftUI

/// 재생 컨트롤 + 타임라인 뷰
struct PlaybackControlView: View {
    @Binding var document: TacticsDocument
    var animationEngine: AnimationEngine

    var body: some View {
        HStack(spacing: 16) {
            // 프레임 네비게이션 & 재생 버튼
            HStack(spacing: 8) {
                Button { animationEngine.stepBackward() } label: {
                    Image(systemName: "backward.frame.fill")
                }
                .help("이전 스텝")

                Button { animationEngine.prevFrame() } label: {
                    Image(systemName: "backward.fill")
                }
                .help("이전 프레임")

                Button {
                    animationEngine.togglePlayPause(totalFrames: document.frameCount)
                } label: {
                    Image(systemName: animationEngine.isPlaying ? "pause.fill" : "play.fill")
                        .frame(width: 24)
                }
                .help(animationEngine.isPlaying ? "일시정지" : "재생")
                .keyboardShortcut(.space, modifiers: [])

                Button { animationEngine.nextFrame(totalFrames: document.frameCount) } label: {
                    Image(systemName: "forward.fill")
                }
                .help("다음 프레임")

                Button { animationEngine.stepForward(totalFrames: document.frameCount) } label: {
                    Image(systemName: "forward.frame.fill")
                }
                .help("다음 스텝")
            }
            .buttonStyle(.borderless)
            .font(.title3)

            Divider()
                .frame(height: 24)

            // 프레임 슬라이더
            Slider(
                value: Binding(
                    get: { Double(animationEngine.currentFrameNumber) },
                    set: { animationEngine.goToFrame(Int($0), totalFrames: document.frameCount) }
                ),
                in: 1...max(1, Double(document.frameCount)),
                step: 1
            )

            // 프레임 카운터
            Text("FRAME \(animationEngine.currentFrameNumber) of \(document.frameCount)")
                .font(.caption.monospaced())
                .foregroundColor(.secondary)
                .frame(minWidth: 120)

            // 프레임 추가 버튼
            Button {
                addFrame()
            } label: {
                Image(systemName: "plus.circle")
            }
            .help("프레임 추가")
            .buttonStyle(.borderless)
        }
    }

    // MARK: - Actions

    private func addFrame() {
        let currentIdx = animationEngine.currentFrameNumber
        let totalFrames = document.frameCount
        let newFrameNumber = totalFrames + 1

        // 이전 프레임 복사 기반으로 새 프레임 생성
        var newFrame = AnimationFrame(
            frameNumber: newFrameNumber,
            scale: document.data.frames.last?.scale ?? document.data.gameInfo.sport.defaultScale
        )
        if let lastFrame = document.data.frames.last {
            newFrame.scale = lastFrame.scale
            newFrame.focusPoint = lastFrame.focusPoint
        }

        document.data.frames.append(newFrame)

        // 모든 스프라이트의 새 프레임 위치 복사
        copySpritesFrameInfo(to: newFrameNumber)

        animationEngine.goToFrame(newFrameNumber, totalFrames: document.frameCount)
    }

    private func copySpritesFrameInfo(to frame: Int) {
        let prevFrame = frame - 1

        // 공
        if let prevInfo = document.data.ball.spriteFrames[prevFrame] {
            var newInfo = prevInfo
            newInfo.isCurve = false
            newInfo.controlPoint = .zero
            newInfo.lineType = .solid
            newInfo.arrowHead = false
            document.data.ball.spriteFrames[frame] = newInfo
        }

        // 홈 선수
        for i in document.data.homePlayers.indices {
            if let prevInfo = document.data.homePlayers[i].spriteFrames[prevFrame] {
                var newInfo = prevInfo
                newInfo.isCurve = false
                newInfo.controlPoint = .zero
                newInfo.lineType = .solid
                newInfo.arrowHead = false
                document.data.homePlayers[i].spriteFrames[frame] = newInfo
            }
        }

        // 원정 선수
        for i in document.data.visitingPlayers.indices {
            if let prevInfo = document.data.visitingPlayers[i].spriteFrames[prevFrame] {
                var newInfo = prevInfo
                newInfo.isCurve = false
                newInfo.controlPoint = .zero
                newInfo.lineType = .solid
                newInfo.arrowHead = false
                document.data.visitingPlayers[i].spriteFrames[frame] = newInfo
            }
        }
    }
}
