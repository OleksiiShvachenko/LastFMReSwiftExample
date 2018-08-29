//
//  CountryCollectionViewCell.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import UIKit
import LastFMReduxState

class CountryCollectionViewCell: UICollectionViewCell, ReusableView {
    
    static let identifier = "\(CountryCollectionViewCell.self)"
    
    static var nib: UINib {
        return UINib(nibName: CountryCollectionViewCell.identifier, bundle: nil)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    
    func setup(with country: Country) {
        countryLabel.text = country.rawValue
        imageView.image = UIImage(named: country.rawValue)
    }
}
