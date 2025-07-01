//
//  Factory.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.07.2025.
//

import Foundation

public protocol Factory {
    associatedtype ViewController
    associatedtype Context

    func build(with context: Context) -> ViewController
}

public extension Factory where Context == Void {
    /// Builds a `Factory`'s view controller.
    func build() -> ViewController {
        build(with: ())
    }
}
