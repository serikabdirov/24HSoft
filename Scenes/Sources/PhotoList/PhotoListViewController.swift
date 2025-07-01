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
        collectionView.allowsMultipleSelection = true

        collectionView.delegate = self

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
            refresh.endRefreshing()
        }
    }

    @objc
    private func refreshAction() {
        loadData()
    }
}

extension PhotoListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
}
