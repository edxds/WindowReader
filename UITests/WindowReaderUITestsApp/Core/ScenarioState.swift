import SwiftUI

class ScenarioState {
    enum InvalidArgumentsError: Error {
        case noIdPassed
        case noTestCasePassed
    }

    private enum LaunchArg: String {
        case id = "--xcuitest-scenario"
        case testCase = "--xcuitest-scenario-case"
    }

    let id: String
    let testCase: String

    init(processInfo: ProcessInfo) throws {
        let reader = ProcessInfoReader(processInfo: processInfo)
        self.id = try reader.value(.id, orThrow: .noIdPassed)
        self.testCase = try reader.value(.testCase, orThrow: .noTestCasePassed)
    }

    static func makeArgs<View: ScenarioView>(
        for scenario: Scenario<View>, with testCase: View.TestCase
    ) -> [String] {
        return [LaunchArg.id.rawValue, scenario.id, LaunchArg.testCase.rawValue, testCase.rawValue]
    }

    private struct ProcessInfoReader {
        var processInfo: ProcessInfo
        func value(_ key: LaunchArg, orThrow error: InvalidArgumentsError) throws -> String {
            guard let value = processInfo.args[key.rawValue] else {
                throw error
            }

            return value
        }
    }
}
