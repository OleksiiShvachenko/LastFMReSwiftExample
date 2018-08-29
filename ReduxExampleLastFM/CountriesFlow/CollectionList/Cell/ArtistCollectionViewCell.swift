//
//  ArtistCollectionViewCell.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import UIKit
import Kingfisher
import LastFMReduxState

class ArtistCollectionViewCell: UICollectionViewCell, ReusableView {
    
    static let identifier = "\(ArtistCollectionViewCell.self)"
    
    static var nib: UINib {
        return UINib(nibName: ArtistCollectionViewCell.identifier, bundle: nil)
    }
    
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var artistTitle: UILabel!
    @IBOutlet weak var artistListeners: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        artistImageView.image = nil
    }
    
    func setup(with artist: Artist) {
        artistTitle.text = artist.name
        artistListeners.text = "\(artist.listeners)" + " listeners"
        guard let url = artist.images.last?.url else { return }
        artistImageView.kf.setImage(with: url)
    }

}
