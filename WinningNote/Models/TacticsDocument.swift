import SwiftUI
import UniformTypeIdentifiers

// MARK: - UTType

extension UTType {
    static var winningNoteTactics: UTType {
        UTType(exportedAs: "com.winningnote.tactics")
    }
}

// MARK: - Document Data

/// 도큐먼트 데이터 모델 (Codable)
struct TacticsData: Codable, Equatable {
    var gameInfo: GameInfo = GameInfo()
    var frames: [AnimationFrame] = []
    var ball: BallSprite = BallSprite()
    var homePlayers: [PlayerSprite] = []
    var visitingPlayers: [PlayerSprite] = []
}

// MARK: - TacticsDocument (FileDocument)

struct TacticsDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.winningNoteTactics, .json] }

    var data: TacticsData

    init() {
        var initialData = TacticsData()
        // 기본 첫 번째 프레임 생성
        let firstFrame = AnimationFrame(
            frameNumber: 1,
            scale: initialData.gameInfo.sport.defaultScale
        )
        initialData.frames = [firstFrame]
        initialData.ball = BallSprite(location: CGPoint(x: 800, y: 1100))
        self.data = initialData
    }

    init(configuration: ReadConfiguration) throws {
        guard let fileData = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        let decoder = JSONDecoder()
        self.data = try decoder.decode(TacticsData.self, from: fileData)
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let jsonData = try encoder.encode(data)
        return FileWrapper(regularFileWithContents: jsonData)
    }
}

// MARK: - Convenience Accessors

extension TacticsDocument {
    /// 모든 선수 (홈 + 원정)
    var allPlayers: [PlayerSprite] {
        data.homePlayers + data.visitingPlayers
    }

    /// 현재 프레임 수
    var frameCount: Int {
        data.frames.count
    }
}
