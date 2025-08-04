//
//  PhotoListInteractor.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.08.2025.
//

import Foundation

protocol NewPhotoListInteractorInput: AnyObject {
    func loadData()
    func updateData()
    func didSelectItem(_ item: Photo)
}

final class NewPhotoListInteractor: NewPhotoListInteractorInput {
    private let presenter: NewPhotoListPresenterInput
    private let router: NewPhotoListRouterInput

    private let apiClient: ApiClient

    init(apiClient: ApiClient, presenter: NewPhotoListPresenterInput, router: NewPhotoListRouterInput) {
        self.apiClient = apiClient
        self.presenter = presenter
        self.router = router
    }

    func loadData() {
        Task {
            do {
                presenter.presentLoading(true)
                let photos = try await apiClient.fetch()
                presenter.presentData(photos)
                presenter.presentLoading(false)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func updateData() {
        Task {
            do {
                let photos = try await apiClient.fetch()
                presenter.presentData(photos)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func didSelectItem(_ item: Photo) {
        router.openDetail(for: item)
    }
}
