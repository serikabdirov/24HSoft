//
//  PhotoListViewController.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.08.2025.
//

import Foundation
import UIKit
import SnapKit

protocol NewPhotoListViewControllerInput: AnyObject {
    func snapshot(_ photos: [Photo]) async
}

final class NewPhotoListViewController: UIViewController {
    typealias CellRegistration = UICollectionView.CellRegistration<PhotoCell, Photo>
    typealias DataSource = UICollectionViewDiffableDataSource<Sections, Photo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Sections, Photo>

    private var collectionView: UICollectionView!
    private var cellRegistration: CellRegistration!
    private var dataSource: DataSource!

    private let refresh = UIRefreshControl()

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

        setupCollectionView()
        setupDataSource()
        setupViews()
        interactor.loadData()
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout(for: UIScreen.main.bounds.size)
        )

        collectionView.delegate = self

        refresh.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        collectionView.refreshControl = refresh
    }

    private func setupDataSource() {
        cellRegistration = CellRegistration { cell, indexPath, item in
            cell.model = item
        }

        dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            guard let self else { return UICollectionViewCell() }

            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)

            return cell
        }
    }

    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func createLayout(for size: CGSize) -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { index, env in
            guard let section = Sections(rawValue: index) else { return nil }

            let isLandscape = size.width > size.height
            return section.sectionLayout(for: isLandscape)
        }
        return layout
    }

    @objc
    private func refreshAction() {
        interactor.updateData()
    }
}

extension NewPhotoListViewController: NewPhotoListViewControllerInput {
    func snapshot(_ photos: [Photo]) async {
        var snapshot = Snapshot()

        snapshot.appendSections([.main])
        snapshot.appendItems(photos, toSection: .main)

        await dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension NewPhotoListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let photo = dataSource.itemIdentifier(for: indexPath) {
            interactor.didSelectItem(photo)
        }
    }
}
