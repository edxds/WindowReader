import SwiftUI
import WindowReader

struct WindowReaderScenario: ScenarioView {
    struct Predicates {
        static let windowDebugText = NSPredicate(format: "value CONTAINS 'AppKitWindow'")
    }

    enum TestCase: String, TestCaseEnum {
        case withBinding
        case withCallback
        case withViewModifier
    }

    var testCase: TestCase

    var body: some View {
        switch testCase {
        case .withBinding:
            WithBindingCase()
        case .withCallback:
            WithCallbackCase()
        case .withViewModifier:
            WithViewModifierCase()
        }
    }
}

struct WithBindingCase: View {
    @State private var window: NSWindow?
    var body: some View {
        WindowReader(window: $window) {
            DebugText(reflecting: window)
        }
    }
}

struct WithCallbackCase: View {
    @State private var window: NSWindow?
    var body: some View {
        WindowReader(
            onMovedToWindow: { window in
                self.window = window
            },
            content: {
                DebugText(reflecting: window)
            })
    }
}

struct WithViewModifierCase: View {
    @State private var window: NSWindow?
    var body: some View {
        VStack {
            DebugText(reflecting: window)
        }
        .onMovedToWindow { window in
            self.window = window
        }
    }
}

extension Scenarios {
    static let windowReader = Scenario<WindowReaderScenario>(id: "windowReaderScenario")
}
