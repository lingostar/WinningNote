import Foundation
import SwiftUI
import Observation

/// 애니메이션 재생 엔진
@Observable
final class AnimationEngine {
    /// 현재 프레임 번호 (1-based)
    var currentFrameNumber: Int = 1

    /// 현재 보간 진행도 (0.0 ~ 1.0)
    var currentDegree: Float = 0.0

    /// 재생 중 여부
    var isPlaying: Bool = false

    /// 프레임 레이트
    let frameRate: Float = 30.0

    private var displayLink: Timer?

    // MARK: - Playback Control

    func play(totalFrames: Int) {
        guard !isPlaying, totalFrames > 1 else { return }
        isPlaying = true
        currentFrameNumber = 1
        currentDegree = 0.0
        startDisplayLink(totalFrames: totalFrames)
    }

    func pause() {
        isPlaying = false
        stopDisplayLink()
    }

    func togglePlayPause(totalFrames: Int) {
        if isPlaying {
            pause()
        } else {
            play(totalFrames: totalFrames)
        }
    }

    func stop(totalFrames: Int) {
        isPlaying = false
        stopDisplayLink()
        currentFrameNumber = totalFrames
        currentDegree = 0.0
    }

    // MARK: - Frame Navigation

    func nextFrame(totalFrames: Int) {
        if currentFrameNumber < totalFrames {
            currentFrameNumber += 1
            currentDegree = 0.0
        }
    }

    func prevFrame() {
        if currentFrameNumber > 1 {
            currentFrameNumber -= 1
            currentDegree = 0.0
        }
    }

    func goToFrame(_ frame: Int, totalFrames: Int) {
        currentFrameNumber = max(1, min(frame, totalFrames))
        currentDegree = 0.0
    }

    // MARK: - Degree Stepping

    func stepForward(totalFrames: Int) {
        currentDegree += 0.03
        if currentDegree >= 1.0 {
            if currentFrameNumber < totalFrames - 1 {
                currentFrameNumber += 1
                currentDegree -= 1.0
            } else {
                currentDegree = 0.0
                currentFrameNumber = totalFrames
            }
        }
    }

    func stepBackward() {
        currentDegree -= 0.03
        if currentDegree < 0 && currentFrameNumber > 1 {
            currentFrameNumber -= 1
            currentDegree += 1.0
        }
    }

    // MARK: - Display Link (Timer-based)

    private func startDisplayLink(totalFrames: Int) {
        displayLink = Timer.scheduledTimer(
            withTimeInterval: TimeInterval(1.0 / frameRate),
            repeats: true
        ) { [weak self] _ in
            self?.tick(totalFrames: totalFrames)
        }
    }

    private func stopDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
    }

    private func tick(totalFrames: Int) {
        // TODO: Use frame interval/delay from AnimationFrame for proper timing
        let step: Float = 1.0 / (frameRate * 1.0) // 1초 기본 인터벌
        currentDegree += step

        if currentDegree >= 1.0 {
            if currentFrameNumber < totalFrames - 1 {
                currentFrameNumber += 1
                currentDegree = 0.0
            } else {
                // 마지막 프레임 도달
                stop(totalFrames: totalFrames)
            }
        }
    }

    deinit {
        stopDisplayLink()
    }
}
