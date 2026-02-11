import SwiftUI
import UniformTypeIdentifiers

@main
struct WinningNoteApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: TacticsDocument()) { file in
            DocumentView(document: file.$document)
        }
        .defaultSize(width: 1200, height: 800)
    }
}
