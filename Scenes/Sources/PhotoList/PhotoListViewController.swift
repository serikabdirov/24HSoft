//
//  PhotoListViewController.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.07.2025.
//

import SnapKit
import UIKit

final class PhotoListViewController: UIViewController {
    private var collectionView: UICollectionView!
    private let refresh = UIRefreshControl()

    private let viewModel: PhotoListViewModel

    init(viewModel: PhotoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        self.viewModel.isLoading = { [weak self] isLoading in
            if isLoading {
                self?.showLoadingOverlay()
            } else {
                self?.hideLoadingOverlay()
            }
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            self.collectionView.setCollectionViewLayout(self.createLayout(for: size), animated: true)
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        viewModel.setupDataSource(for: collectionView)
        setupViews()

        loadData()
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout(for: UIScreen.main.bounds.size)
        )

        collectionView.delegate = self
        collectionView.isPrefetchingEnabled = true
        collectionView.prefetchDataSource = self

        refresh.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        collectionView.refreshControl = refresh
    }

    private func createLayout(for size: CGSize) -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { index, env in
            guard let section = Sections(rawValue: index) else { return nil }

            let isLandscape = size.width > size.height
            return section.sectionLayout(for: isLandscape)
        }
        return layout
    }

    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func loadData() {
        Task {
            await viewModel.loadData()
        }
    }

    func updateData() {
        Task {
            await viewModel.updateData()
            refresh.endRefreshing()
        }
    }

    @objc
    private func refreshAction() {
        updateData()
    }

    private func showLoadingOverlay() {
        LoadingOverlay.shared.show(over: view)
    }

    private func hideLoadingOverlay() {
        LoadingOverlay.shared.hide()
    }
}

extension PhotoListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let photo = viewModel.getPhoto(at: indexPath) {
            navigationController?.pushViewController(PhotoDetailViewController(photo: photo), animated: true)
        }
    }
}

extension PhotoListViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        viewModel.startPrefetching(for: indexPaths)
    }

    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        viewModel.stopPrefetching(for: indexPaths)
    }
}
