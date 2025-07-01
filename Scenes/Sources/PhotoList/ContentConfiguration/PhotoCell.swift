//
//  PhotoCell.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.07.2025.
//

import UIKit

final class PhotoCell: UICollectionViewCell {
    var model: Photo?

    override func updateConfiguration(using state: UICellConfigurationState) {
        var newConfiguration = PhotoContentConfiguration().updated(for: state)
        let newBackgroundConfiguration = PhotoBackgroundConfiguration(photoColor: model?.uiColor).configuration(for: state)

        newConfiguration.description = model?.displayDescription
        newConfiguration.likes = "❤️ \(model?.likes ?? 0)"
        newConfiguration.image = model?.thumb
        newConfiguration.color = model?.uiColor.darker()

        contentConfiguration = newConfiguration
        backgroundConfiguration = newBackgroundConfiguration
    }
}
