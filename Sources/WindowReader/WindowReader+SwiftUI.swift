import SwiftUI

public extension View {
    func onMovedToWindow(_ callback: @escaping NSWindowCallback) -> some View {
        return background(
            WindowReader(onMovedToWindow: callback)
        )
    }
}
