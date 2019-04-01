//
//  CountriesCollectionViewController.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import UIKit
import Hero
import LastFMReduxState

class CountriesCollectionViewController: UICollectionViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView?.register(CountryCollectionViewCell.nib,
                             forCellWithReuseIdentifier: CountryCollectionViewCell.identifier)
    collectionView?.reloadData()
    collectionView?.hero.modifiers = [.cascade(delta: 0.1, direction: .topToBottom, delayMatchedViews: true)]
  }
  
  func tapCollection() {
    dismiss(animated: true, completion: nil)
  }
  
}

// MARK: - CollectionView
extension CountriesCollectionViewController {
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Country.all.count
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCollectionViewCell.identifier,
                                                        for: indexPath) as? CountryCollectionViewCell
      else { fatalError() }
    cell.setup(with: Country.all[indexPath.row])
    cell.hero.modifiers = [.fade, .scale(0.5)]
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    mainStore.dispatch(ArtistsState.ActionCreators.selectCountry(Country.all[indexPath.row]))
    dismiss(animated: true, completion: nil)
  }
}
