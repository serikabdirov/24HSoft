//
//  PhotoListFactory.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.07.2025.
//

import Foundation
import UIKit

final class PhotoListFactory: @preconcurrency Factory {
    typealias Context = Void

    @MainActor func build(with context: Context) -> some UIViewController {
        let viewModel = PhotoListViewModel(apiClient: ApiClient.shared)
        let vc = PhotoListViewController(viewModel: viewModel)
        return vc
    }
}
