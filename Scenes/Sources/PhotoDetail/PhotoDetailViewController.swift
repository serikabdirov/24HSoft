//
//  PhotoDetailViewController.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.07.2025.
//

import SnapKit
import UIKit
import NukeExtensions

final class PhotoDetailViewController: UIViewController {
    private let imageView = UIImageView()

    private let imageLoadingOptions = ImageLoadingOptions(
        placeholder: UIImage(systemName: "photo.badge.arrow.down"),
        failureImage: UIImage(systemName: "photo.badge.exclamationmark"),
        contentModes: .init(
            success: .scaleAspectFit,
            failure: .center,
            placeholder: .center
        )
    )

    private let photo: Photo

    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        navigationItem.title = photo.user.username
        view.backgroundColor = .white

        loadImage(with: photo.regular, options: imageLoadingOptions, into: imageView)
    }

    private func setupViews() {
        imageView.contentMode = .scaleAspectFit

        view.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
