//
//  Photo.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.07.2025.
//

import Foundation
import UIKit

struct Photo: Codable, Identifiable, Hashable {
    struct Urls: Codable, Hashable {
        let thumb: URL
    }

    let id: String
    let description: String?
    let altDescription: String?
    let color: String
    let urls: Urls
    let likes: Int

    var displayDescription: String? { description ?? altDescription ?? "NO DESCRIPTION" }
    var thumb: URL { urls.thumb }
    var uiColor: UIColor { UIColor(hex: color) }
}
