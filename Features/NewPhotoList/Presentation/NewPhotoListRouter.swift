//
//  PhotoListRouter.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.08.2025.
//

import Foundation
import UIKit

protocol NewPhotoListRouterInput: AnyObject {

}

final class NewPhotoListRouter: NewPhotoListRouterInput {
    weak var viewController: UIViewController?
}
