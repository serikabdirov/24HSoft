//
//  PhotoListViewController.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.08.2025.
//

import Foundation
import UIKit

protocol NewPhotoListViewControllerInput: AnyObject {

}

final class NewPhotoListViewController: UIViewController, NewPhotoListViewControllerInput {
    private let interactor: any PhotoListInteractorInput

    init(interactor: any PhotoListInteractorInput) {
        self.interactor = interactor

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
