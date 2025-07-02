//
//  PhotoContent.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.07.2025.
//

import Nuke
import NukeExtensions
import SnapKit
import UIKit

final class PhotoContent: UIView, UIContentView {
    var currentConfiguration: PhotoContentConfiguration!

    var configuration: UIContentConfiguration {
        get {
            currentConfiguration
        }
        set {
            guard let newConfiguration = newValue as? PhotoContentConfiguration else {
                return
            }

            apply(configuration: newConfiguration)
        }
    }

    let descriptionLabel = UILabel()
    let likesLabel = UILabel()
    let imageView = UIImageView()

    let labelsStackView = UIStackView()

    let imageLoadingOptions = ImageLoadingOptions(
        placeholder: UIImage(systemName: "photo.badge.arrow.down"),
        failureImage: UIImage(systemName: "photo.badge.exclamationmark"),
        contentModes: .init(
            success: .scaleAspectFit,
            failure: .center,
            placeholder: .center
        )
    )

    init(_ configuration: PhotoContentConfiguration) {
        super.init(frame: .zero)
        setupViews()

        apply(configuration: configuration)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupViews() {
        descriptionLabel.textAlignment = .left
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 2

        likesLabel.textAlignment = .left
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.numberOfLines = 2

        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fillProportionally

//        imageView.contentMode = .scaleAspectFit

        labelsStackView.addArrangedSubview(descriptionLabel)
        labelsStackView.addArrangedSubview(likesLabel)

        addSubview(labelsStackView)
        addSubview(imageView)

        labelsStackView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview().inset(20)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
        }

        imageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(20)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
    }

    private func apply(configuration: PhotoContentConfiguration) {
        guard currentConfiguration != configuration else {
            return
        }

        currentConfiguration = configuration

        descriptionLabel.text = configuration.description
        descriptionLabel.textColor = configuration.color

        likesLabel.text = configuration.likes
        likesLabel.textColor = configuration.color

        loadImage(with: configuration.image, options: imageLoadingOptions, into: imageView)
    }
}
