//
//  PhotoListInteractor.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.08.2025.
//

import Foundation

protocol PhotoListInteractorInput: AnyObject {
    func loadData()
    func updateData()
    func didSelectItem(_ item: Photo)
}

final class PhotoListInteractor: PhotoListInteractorInput {
    private let presenter: any PhotoListPresenterInput
    private let router: any PhotoListRouterInput

    init(presenter: any PhotoListPresenterInput, router: any PhotoListRouterInput) {
        self.presenter = presenter
        self.router = router
    }

    func loadData() {

    }

    func updateData() {
        
    }

    func didSelectItem(_ item: Photo) {
        
    }
}
