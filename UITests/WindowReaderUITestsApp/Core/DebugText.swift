import SwiftUI

struct DebugText<Subject>: View {
    var reflecting: Subject

    var body: some View {
        Text(verbatim: String(reflecting: reflecting))
    }
}
