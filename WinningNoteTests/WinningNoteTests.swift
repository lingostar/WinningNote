import XCTest
@testable import WinningNote

final class WinningNoteTests: XCTestCase {

    func testTacticsDocumentInitialization() throws {
        let document = TacticsDocument()
        XCTAssertEqual(document.data.frames.count, 1)
        XCTAssertEqual(document.data.gameInfo.sport, .soccer)
        XCTAssertEqual(document.data.homePlayers.count, 0)
        XCTAssertEqual(document.data.visitingPlayers.count, 0)
    }

    func testBezierCurveQuadratic() throws {
        let start = CGPoint(x: 0, y: 0)
        let end = CGPoint(x: 100, y: 100)
        let control = CGPoint(x: 50, y: 0)

        let mid = BezierCurve.quadratic(from: start, to: end, control: control, t: 0.5)
        XCTAssertEqual(mid.x, 50, accuracy: 0.01)
        XCTAssertEqual(mid.y, 25, accuracy: 0.01)
    }

    func testSportTypeFieldSizes() throws {
        XCTAssertEqual(SportType.soccer.fieldSize, CGSize(width: 1600, height: 2200))
        XCTAssertEqual(SportType.basketball.fieldSize, CGSize(width: 850, height: 1500))
    }

    func testTacticsDataCodable() throws {
        let document = TacticsDocument()
        let encoder = JSONEncoder()
        let data = try encoder.encode(document.data)
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(TacticsData.self, from: data)
        XCTAssertEqual(document.data, decoded)
    }
}
