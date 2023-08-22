//
//  CharactersListViewController.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation
import Combine
import UIKit

final class CharactersListViewController: MvvmViewController<CharactersListViewModel> {
    // MARK: - Views
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = grid.itemSpacing
        layout.minimumLineSpacing = grid.itemSpacing
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: grid.verticalPadding, left: grid.sidePadding,
                                           bottom: grid.verticalPadding, right: grid.sidePadding)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = SelfSizingCollectionView(frame: .zero,
                                                  collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.register(cellClass: CharacterCell.self)
        collection.backgroundColor = appearance.background
        collection.allowsSelection = true
        return collection
    }()
    
    private lazy var refresherView: UIRefreshControl = UIRefreshControl()
    
    // MARK: - Properties
    enum Event {
        case showCharacter(character: Result)
    }
    
    var onEvent: ValueClosure<Event>?
    
    // MARK: - Private properties
    private lazy var dataSource: UICollectionViewDiffableDataSource<MainSection, ResultItem> = makeDataSource()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        bindViewModel()
        
        viewModel.initialize()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        bind(viewModel.charactersData) { [weak self] _ in
            guard let self = self else { return }
            self.refresherView.endRefreshing()
            self.updateCollectionViewData()
        }
        
        bind(viewModel.reloadViewCommand) { [weak self] in
            self?.viewModel.resetPage()
            self?.viewModel.getData()
        }
        
        bind(viewModel.showCharacterCommand) { [weak self] in
            self?.onEvent?(.showCharacter(character: $0))
        }
    }
    
    // MARK: - Private methods
    private func makeDataSource() -> UICollectionViewDiffableDataSource<MainSection, ResultItem> {
        dataSource = UICollectionViewDiffableDataSource<MainSection, ResultItem>(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, item) in
                let cell = collectionView.dequeue(cellClass: CharacterCell.self, forIndexPath: indexPath)
                cell.fill(with: item)
                return cell
            })
        collectionView.dataSource = dataSource
        return dataSource
    }
    
    private func updateCollectionViewData() {
        var snapshot = NSDiffableDataSourceSnapshot<MainSection, ResultItem>()
        snapshot.appendSections([.general])
        snapshot.appendItems(viewModel.charactersData.value, toSection: .general)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Setup views
extension CharactersListViewController {
    private func setupViews() {
        view.backgroundColor = appearance.background
        view.addSubview(collectionView)
        collectionView.addSubview(refresherView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - CollectionView Delegate
extension CharactersListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 2
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let sideSpacing: CGFloat = grid.sidePadding
        let availableWidth = width - spacing * (numberOfItemsPerRow - 1) - sideSpacing * numberOfItemsPerRow
        let itemWidth = floor(availableWidth / numberOfItemsPerRow)
        let itemHeight = itemWidth * 4 / 3
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.characters.value.count - 1 {
            viewModel.getNextData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.getItem(by: indexPath)
        viewModel.showCharacter(by: item.id)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refresherView.isRefreshing {
            viewModel.reloadViewCommand.call()
        }
    }
}

// MARK: - Resources
private extension AppearanceConstants {
    var background: UIColor { colors.background }
    var gray: UIColor { .secondaryLabel }
    var emptyFont: UIFont { fonts.normalMedium }
}

private extension GridConstants {
    var sidePadding: CGFloat { 20 }
    var verticalPadding: CGFloat { 30 }
    var itemSpacing: CGFloat { 16 }
}
