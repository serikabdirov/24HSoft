//
//  PhotoListRouter.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.08.2025.
//

import Foundation
import UIKit

protocol NewPhotoListRouterInput: AnyObject {
    func openDetail(for photo: Photo)
}

final class NewPhotoListRouter: NewPhotoListRouterInput {
    weak var viewController: UIViewController?

    func openDetail(for photo: Photo) {
        let detailViewController = PhotoDetailViewController(photo: photo)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
