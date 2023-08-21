//
//  SelfSizingCollectionView.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 22.08.2023.
//

import UIKit

class SelfSizingCollectionView: UICollectionView {
    override var contentSize: CGSize {
        didSet {
            if oldValue.height != self.contentSize.height {
                invalidateIntrinsicContentSize()
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric,
                      height: contentSize.height)
    }
}
