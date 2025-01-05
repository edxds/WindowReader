import SwiftUI

// swiftlint:disable force_try
@main
struct UITestsApp: App {
    let state = try! ScenarioState(processInfo: ProcessInfo.processInfo)

    var body: some Scene {
        Window("Test Shell", id: "test-shell-window") {
            switch state.id {
            case Scenarios.windowReader.id:
                try! WindowReaderScenario(state)
            default:
                fatalError("Unknown scenario ID passed to test app: \(state.id)")
            }
        }
    }
}
// swiftlint:enable force_try
