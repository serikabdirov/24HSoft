//
//  PhotoListPresenter.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.08.2025.
//

import Foundation

protocol PhotoListPresenterInput: AnyObject {
    func presentData(_ data: [Photo])
    func presentLoading(_ isLoading: Bool)
}

final class PhotoListPresenter: PhotoListPresenterInput {
    weak var viewController: (any NewPhotoListViewControllerInput)?

    func presentData(_ data: [Photo]) {
        viewController?.configure(with: data)
    }

    func presentLoading(_ isLoading: Bool) {
        viewController?.presentLoading(isLoading)
    }
}
