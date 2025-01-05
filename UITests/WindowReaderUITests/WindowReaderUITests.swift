import XCTest

final class WindowReaderUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    @MainActor
    func testWindowReaderWithBinding() throws {
        let app = launchAppWithCase(.withBinding)
        assertBaselineWindowReaderExpectations(app)
    }

    @MainActor
    func testWindowReaderWithCallback() throws {
        let app = launchAppWithCase(.withCallback)
        assertBaselineWindowReaderExpectations(app)
    }

    @MainActor
    func testWindowReaderWithViewModifier() throws {
        let app = launchAppWithCase(.withViewModifier)
        assertBaselineWindowReaderExpectations(app)
    }

    private func launchAppWithCase(_ testCase: WindowReaderScenario.TestCase) -> XCUIApplication {
        let app = XCUIApplication()
        app.request(scenario: Scenarios.windowReader, case: testCase)
        app.launch()
        app.activate()
        return app
    }

    private func assertBaselineWindowReaderExpectations(_ app: XCUIApplication) {
        let windowDescription = app.staticTexts.matching(WindowReaderScenario.Predicates.windowDebugText)
        XCTAssertTrue(windowDescription.element.waitForExistence(timeout: 10), "Window debug text must not be nil")
    }
}
