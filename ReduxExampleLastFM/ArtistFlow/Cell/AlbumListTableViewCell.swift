//
//  AlbumListTableViewCell.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/8/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import UIKit
import Kingfisher
import LastFMReduxState

class AlbumListTableViewCell: UITableViewCell, ReusableView {
    
    static let identifier = "\(AlbumListTableViewCell.self)"
    
    static var nib: UINib {
        return UINib(nibName: AlbumListTableViewCell.identifier, bundle: nil)
    }
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var albumPlays: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumImageView.image = nil
    }
    
    func setup(with album: Album) {
        albumTitle.text = album.name
        albumPlays.text = "\(album.playcount)" + " plays"
        guard let url = album.images.last?.url else { return }
        albumImageView.kf.setImage(with: url)
    }
    
}
