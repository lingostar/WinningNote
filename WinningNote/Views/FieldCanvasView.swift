import SwiftUI

/// 필드 + 스프라이트 렌더링 캔버스
struct FieldCanvasView: View {
    @Binding var document: TacticsDocument
    var animationEngine: AnimationEngine

    var body: some View {
        GeometryReader { geometry in
            ScrollView([.horizontal, .vertical]) {
                Canvas { context, size in
                    drawField(context: &context, size: size)
                    drawBall(context: &context)
                    drawPlayers(context: &context)
                }
                .frame(
                    width: fieldDisplaySize.width,
                    height: fieldDisplaySize.height
                )
            }
        }
        .background(Color(white: 0.15))
    }

    // MARK: - Computed

    private var currentScale: CGFloat {
        guard let frame = currentFrame else { return 0.6 }
        return CGFloat(frame.scale) / 100.0
    }

    private var currentFrame: AnimationFrame? {
        let idx = animationEngine.currentFrameNumber - 1
        guard idx >= 0, idx < document.data.frames.count else { return nil }
        return document.data.frames[idx]
    }

    private var fieldSize: CGSize {
        document.data.gameInfo.sport.fieldSize
    }

    private var fieldDisplaySize: CGSize {
        CGSize(
            width: fieldSize.width * currentScale,
            height: fieldSize.height * currentScale
        )
    }

    // MARK: - Drawing

    private func drawField(context: inout GraphicsContext, size: CGSize) {
        // 배경
        context.fill(
            Path(CGRect(origin: .zero, size: size)),
            with: .color(.green.opacity(0.6))
        )

        // TODO: 종목별 필드 라인 드로잉 (FieldRenderer 연동)
    }

    private func drawBall(context: inout GraphicsContext) {
        let ball = document.data.ball
        let rect = ball.rect(
            at: animationEngine.currentFrameNumber,
            degree: animationEngine.currentDegree
        )
        let scaledRect = rect.applying(CGAffineTransform(scaleX: currentScale, y: currentScale))

        // 그림자
        context.drawLayer { ctx in
            ctx.addFilter(.shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: -2))
            ctx.fill(Ellipse().path(in: scaledRect), with: .color(.black.opacity(0.9)))
        }

        // 테두리
        let strokeRect = scaledRect.insetBy(dx: 2, dy: 2)
        context.stroke(Ellipse().path(in: strokeRect), with: .color(.white), lineWidth: 2)
    }

    private func drawPlayers(context: inout GraphicsContext) {
        let allPlayers = document.allPlayers
        for player in allPlayers {
            let rect = player.rect(
                at: animationEngine.currentFrameNumber,
                degree: animationEngine.currentDegree
            )
            let scaledRect = rect.applying(CGAffineTransform(scaleX: currentScale, y: currentScale))
            let color = player.playerColor.color

            // 그림자 + 채우기
            context.drawLayer { ctx in
                ctx.addFilter(.shadow(color: .black.opacity(0.5), radius: 2, x: 3, y: -3))
                switch player.shape {
                case .circle:
                    ctx.fill(Ellipse().path(in: scaledRect), with: .color(color))
                case .square:
                    ctx.fill(Path(scaledRect), with: .color(color))
                }
            }

            // 테두리
            let strokeRect = scaledRect.insetBy(dx: 4, dy: 4)
            switch player.shape {
            case .circle:
                context.stroke(Ellipse().path(in: strokeRect), with: .color(.white), lineWidth: 3)
            case .square:
                context.stroke(Path(strokeRect), with: .color(.white), lineWidth: 3)
            }

            // 등번호
            context.draw(
                Text(player.backNumber)
                    .font(.system(size: 14 * currentScale, weight: .bold))
                    .foregroundColor(.white),
                at: CGPoint(x: scaledRect.midX, y: scaledRect.midY)
            )
        }
    }
}
