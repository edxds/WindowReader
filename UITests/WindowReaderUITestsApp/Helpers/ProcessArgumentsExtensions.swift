import SwiftUI

extension ProcessInfo {
    var args: ArgumentDictionary {
        makeArgumentDictionary(from: self.arguments)
    }
}
