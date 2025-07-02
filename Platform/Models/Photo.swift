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
        let regular: URL
    }

    struct User: Codable, Hashable {
        let username: String
    }

    let id: String
    let description: String?
    let altDescription: String?
    let color: String
    let urls: Urls
    let likes: Int
    let user: User

    var displayDescription: String? { description ?? altDescription ?? "NO DESCRIPTION" }
    var thumb: URL { urls.thumb }
    var regular: URL { urls.regular }
    var uiColor: UIColor { UIColor(hex: color) }
}
