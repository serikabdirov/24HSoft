//
//  PhotoListPresenter.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.08.2025.
//

import Foundation

protocol PhotoListPresenterInput: AnyObject {

}

final class PhotoListPresenter: PhotoListPresenterInput {
    weak var viewController: (any NewPhotoListViewControllerInput)?
}
