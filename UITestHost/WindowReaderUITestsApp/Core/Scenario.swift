enum TestCaseError: Error {
    case invalidCaseProvided(String)
}

protocol TestCaseEnum: RawRepresentable where RawValue == String {
}

extension TestCaseEnum where RawValue == String {
    static func from(rawValue: String) throws -> Self {
        guard let result = self.init(rawValue: rawValue) else {
            throw TestCaseError.invalidCaseProvided(rawValue)
        }

        return result
    }
}

struct Scenario<View: ScenarioView>: Identifiable {
    var id: String
}

struct Scenarios {}
