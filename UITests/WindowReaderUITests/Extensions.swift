import XCTest

extension XCUIElementQuery {
    func matching<T: RawRepresentable>(identifier: T) -> XCUIElementQuery where T.RawValue == String {
        return self.matching(identifier: identifier.rawValue)
    }
}

extension XCUIApplication {
    func request<T: ScenarioView>(scenario: Scenario<T>, case testCase: T.TestCase) {
        self.launchArguments = ScenarioState.makeArgs(for: scenario, with: testCase)
    }
}
