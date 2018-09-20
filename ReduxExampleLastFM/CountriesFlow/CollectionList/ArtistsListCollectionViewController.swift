//
//  ArtistsListCollectionViewController.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import UIKit
import ReSwift
import LastFMReduxState

class AutoLayoutCollectionView: UICollectionView {
  
  private var shouldInvalidateLayout = false

  override func layoutSubviews() {
    super.layoutSubviews()
    if shouldInvalidateLayout {
      collectionViewLayout.invalidateLayout()
      shouldInvalidateLayout = false
    }
  }

  override func reloadData() {
    shouldInvalidateLayout = true
    super.reloadData()
  }
}

class ArtistsListCollectionViewController: UICollectionViewController {
    
    struct Model: ViewControllerModel {
        let artists: [Artist]
        let error: String?
    }
    
    var model: Model! { didSet { render(model) } }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(ArtistCollectionViewCell.nib,
                                 forCellWithReuseIdentifier: ArtistCollectionViewCell.identifier)
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 160, height: 160)
        }
        collectionView?.contentInset = UIEdgeInsets.zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self) { $0.select(ArtistsListLens.lens) }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mainStore.unsubscribe(self)
    }
}

// MARK: - Collection View
extension ArtistsListCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.artists.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistCollectionViewCell.identifier,
                                                            for: indexPath) as? ArtistCollectionViewCell
            else { fatalError() }
        cell.setup(with: model.artists[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainStore.dispatch(CountryArtistsState.ActionCreators.didTapOnArtist(at: indexPath.row))
        guard let controller = AppStoryboard.artist.initialViewController else { fatalError() }
        navigationController?.show(controller, sender: nil)
    }
}

// MARK: - store subscriber
extension ArtistsListCollectionViewController: StoreSubscriber {
    func newState(state: (artists: [Artist], error: String?)) {
        model = Model(artists: state.artists, error: state.error)
    }
}

// MARK: - model supporting
extension ArtistsListCollectionViewController: ViewControllerModelSupport, ErrorHandlerController {
    func render(_ model: Model) {
        show(error: model.error)
        collectionView?.reloadData()
    }
}
