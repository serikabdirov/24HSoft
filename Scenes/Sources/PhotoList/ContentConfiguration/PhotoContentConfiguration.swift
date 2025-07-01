//
//  PhotoContentConfiguration.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.07.2025.
//

import UIKit

struct PhotoContentConfiguration: UIContentConfiguration, Hashable {
    var description: String?
    var likes: String?
    var image: URL?
    var color: UIColor?

    func makeContentView() -> any UIView & UIContentView {
        PhotoContent(self)
    }

    func updated(for state: any UIConfigurationState) -> PhotoContentConfiguration {
        guard state is UICellConfigurationState else { return self }

        let newState = self

        return newState
    }
}

struct PhotoBackgroundConfiguration {
    let photoColor: UIColor?

    func configuration(for state: UICellConfigurationState) -> UIBackgroundConfiguration {
        var backgroundConfig = UIBackgroundConfiguration.clear()

        backgroundConfig.backgroundColor = photoColor

        if state.isHighlighted {
            backgroundConfig.backgroundColorTransformer = .init { $0.darker(by: -0.9) }
        } else {
            backgroundConfig.backgroundColorTransformer = .init { $0.darker(by: -0.5) }
        }
        
        return backgroundConfig
    }
}
