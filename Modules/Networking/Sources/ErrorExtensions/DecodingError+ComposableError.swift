import Core
import Foundation

extension DecodingError: ComposableError {
    public var underlyingComposableError: ComposableError? {
        nil
    }

    public var identifiableCode: String {
        String(describing: self)
    }
}
