//
//  PhotoListRouter.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.08.2025.
//

import Foundation
import UIKit

protocol PhotoListRouterInput: AnyObject {

}

final class PhotoListRouter: PhotoListRouterInput {
    weak var viewController: UIViewController?
}
