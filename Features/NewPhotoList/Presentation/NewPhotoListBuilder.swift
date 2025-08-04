//
//  PhotoListBuilder.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.08.2025.
//

import Foundation
import UIKit

public final class NewPhotoListBuilder {
    func make() -> UIViewController {
        let presenter = NewPhotoListPresenter()
        let router = NewPhotoListRouter()
        let interactor = NewPhotoListInteractor(apiClient: ApiClient.shared, presenter: presenter, router: router)

        let viewController = NewPhotoListViewController(interactor: interactor)

        presenter.viewController = viewController
        router.viewController = viewController

        return viewController
    }
}
