//
//  PhotoListViewModel.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.07.2025.
//

import UIKit

final class PhotoListViewModel {
    typealias CellRegistration = UICollectionView.CellRegistration<PhotoCell, Photo>
    typealias DataSource = UICollectionViewDiffableDataSource<Sections, Photo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Sections, Photo>

    private var cellRegistration: CellRegistration!
    private var dataSource: DataSource!

    private let apiClient: ApiClient

    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }

    func setupDataSource(for collectionView: UICollectionView) {
        cellRegistration = CellRegistration { cell, indexPath, item in
            cell.model = item
        }

        dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            guard let self else { return UICollectionViewCell() }

            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)

            return cell
        }
    }

    private func snapshot(_ photos: [Photo]) async {
        var snapshot = Snapshot()

        snapshot.appendSections([.main])
        snapshot.appendItems(photos, toSection: .main)

        await dataSource.apply(snapshot, animatingDifferences: true)
    }

    func loadData() async {
        do {
            let photos = try await apiClient.fetch()
            await snapshot(photos)
        } catch {
            print(error.localizedDescription)
        }
    }

    func didSelectItem(at indexPath: IndexPath) {
        if let identifier = dataSource.itemIdentifier(for: indexPath) {
            print(identifier)
            print(indexPath)
        }
    }
}

enum Sections: Int, Hashable {
    case main

    func sectionLayout(for isLandscape: Bool) -> NSCollectionLayoutSection {
        switch self {
        case .main:
            Self.main(isLandscape: isLandscape)
        }
    }

    static func main(isLandscape: Bool) -> NSCollectionLayoutSection {
        let itemsPerRow: CGFloat = isLandscape ? 2 : 1
        let itemWidth = 1.0 / itemsPerRow

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemWidth),
            heightDimension: .absolute(200)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(200)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: Array(repeating: item, count: Int(itemsPerRow))
        )

        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
