import AppKit
import SwiftUI

public typealias NSWindowCallback = (NSWindow?) -> Void

public struct WindowReader<Content: View>: NSViewRepresentable {
    private var binding: Binding<NSWindow?>?
    private var callback: NSWindowCallback?
    private var content: Content

    public init(
        window binding: Binding<NSWindow?>? = nil,
        onMovedToWindow callback: NSWindowCallback? = nil,
        @ViewBuilder content viewBuilder: () -> Content
    ) {
        self.binding = binding
        self.callback = callback
        content = viewBuilder()
    }

    public func makeCoordinator() -> WindowReaderCoordinator {
        WindowReaderCoordinator { @MainActor window in
            self.binding?.wrappedValue = window
            self.callback?(window)
        }
    }

    public func makeNSView(context _: Context) -> NSWindowReader<Content> {
        NSWindowReader(rootView: content)
    }

    public func updateNSView(_ nsView: NSWindowReader<Content>, context: Context) {
        nsView.delegate = context.coordinator
        nsView.rootView = content
    }
}

public extension WindowReader where Content == EmptyView {
    init(window binding: Binding<NSWindow?>? = nil, onMovedToWindow callback: NSWindowCallback? = nil) {
        self.binding = binding
        self.callback = callback
        content = ViewBuilder.buildBlock()
    }
}

public class WindowReaderCoordinator: NSWindowReaderDelegate {
    private let callback: NSWindowCallback

    init(_ closure: @escaping NSWindowCallback) {
        callback = closure
    }

    public func reader<Content: View>(_: NSWindowReader<Content>, didMoveTo window: NSWindow?) {
        callback(window)
    }
}

public class NSWindowReader<Content: View>: NSHostingView<Content> {
    var delegate: NSWindowReaderDelegate?

    override public func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        delegate?.reader(self, didMoveTo: window)
    }
}

public protocol NSWindowReaderDelegate: AnyObject {
    func reader<Content: View>(_ view: NSWindowReader<Content>, didMoveTo window: NSWindow?)
}
