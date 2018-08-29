//
//  CountriesCollectionViewLayout.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import UIKit

class CountriesCollectionViewLayout: UICollectionViewLayout {
    
    var layoutAttributes = [String: UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
        layoutAttributes.removeAll()
        guard collectionView!.numberOfSections > 0 else { return }
        setupCellAttributes()
    }
    
    func setupCellAttributes() {
        for index in 0...4 {
            let path = IndexPath(row: index, section: 0)
            let key = layoutKeyForIndexPath(indexPath: path)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: path)
            attributes.frame = CGRect(x: 20, y: 70 + (index * 80), width: 200, height: 60)
            layoutAttributes[key] = attributes
        }
    }
    
    func layoutKeyForIndexPath(indexPath: IndexPath) -> String {
        return "\(indexPath.section)_\(indexPath.row)"
    }
    
    func layoutKeyForHeaderAtIndexPath(indexPath: IndexPath) -> String {
        return "s_\(indexPath.section)_\(indexPath.row)"
    }
    
    override var collectionViewContentSize: CGSize {
        return collectionView?.frame.size ?? CGSize.zero
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String,
                                                       at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let key = layoutKeyForHeaderAtIndexPath(indexPath: indexPath)
        return layoutAttributes[key]
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let key = layoutKeyForIndexPath(indexPath: indexPath)
        return layoutAttributes[key]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let predicate = NSPredicate { [unowned self] (evaluatedObject, _) -> Bool in
            guard let evaluatedObject = evaluatedObject as? String else { fatalError() }
            let layoutAttribute = self.layoutAttributes[evaluatedObject]
            return rect.intersects(layoutAttribute!.frame)
        }
        
        let dict = layoutAttributes as NSDictionary
        let keys = dict.allKeys as NSArray
        let matchingKeys = keys.filtered(using: predicate)
        
        return dict.objects(forKeys: matchingKeys, notFoundMarker: NSNull()) as? [UICollectionViewLayoutAttributes]
    }

}
