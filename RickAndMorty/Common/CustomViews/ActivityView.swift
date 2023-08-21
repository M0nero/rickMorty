//
//  ActivityView.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation
import UIKit
import SnapKit

final class ActivityView: UIView {
    // MARK: - Views
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.tintColor = appearance.gray
        activityIndicator.color = appearance.gray
        return activityIndicator
    }()
    
    private lazy var boxView: UIView = {
        let view = UIView()
        view.backgroundColor = appearance.background
        view.clipsToBounds = true
        view.layer.cornerRadius = grid.space16
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func setState(_ isLoading: Bool) {
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        isHidden = !isLoading
    }
}

// MARK: - Setup views
extension ActivityView {
    private func setupView() {
        backgroundColor = .init(white: 0, alpha: 0.1)
        isUserInteractionEnabled = false
        isHidden = true
        addSubview(boxView)
        boxView.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        boxView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(grid.boxSize)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

// MARK: - Resources
private extension AppearanceConstants {
    var background: UIColor { .tertiarySystemBackground }
    var gray: UIColor { .systemGray }
}

private extension GridConstants {
    var boxSize: CGFloat { 80 }
}
