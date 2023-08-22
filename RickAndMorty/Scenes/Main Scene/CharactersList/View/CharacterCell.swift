//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 22.08.2023.
//

import UIKit

final class CharacterCell: UICollectionViewCell {
    // MARK: - Views
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = grid.imageRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = appearance.titleFont
        label.textColor = appearance.titleColor
        return label
    }()
    
    private lazy var rootStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            imageView,
            nameLabel
        ])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = appearance.cellColor
        view.layer.cornerRadius = grid.cellRadius
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    // MARK: - Public methods
    func fill(with item: ResultItem) {
        imageView.downloaded(from: item.imageUrl)
        nameLabel.text = item.title
    }
}

// MARK: - Setup Views
extension CharacterCell {
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(rootStack)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        rootStack.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(grid.padding)
            $0.bottom.equalToSuperview()
        }
        
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
    }
}

// MARK: - Resources
private extension AppearanceConstants {
    var titleFont: UIFont { fonts.normalMedium }
    var cellColor: UIColor { colors.gunmetal }
    var titleColor: UIColor { .white }
}

private extension GridConstants {
    var cellRadius: CGFloat { 16 }
    var imageRadius: CGFloat { 10 }
    var padding: CGFloat { 8 }
}
