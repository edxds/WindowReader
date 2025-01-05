import SwiftUI

protocol ScenarioView: View {
    associatedtype TestCase: TestCaseEnum
    var testCase: TestCase { get }
    init(testCase: TestCase)
}

extension ScenarioState {
    func testCase<View: ScenarioView>(for view: View.Type) throws -> View.TestCase {
        try View.TestCase.from(rawValue: self.testCase)
    }
}

extension ScenarioView {
    init(_ state: ScenarioState) throws {
        self.init(testCase: try state.testCase(for: Self.self))
    }
}
