//
//  ArtistsListContainerViewController.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import UIKit
import ReSwift
import LastFMReduxState

struct ArtistsListContainerLens: Lens {
  static func lens(_ state: AppState) -> Country {
    return state.artistsByCountryState.country
  }
}

class CustomTitleView: UIView {
  override var intrinsicContentSize: CGSize {
    return UILayoutFittingExpandedSize
  }
}

class ArtistsListContainerViewController: UIViewController {
  
  struct Model: ViewControllerModel {
    let country: Country
  }
  
  var model: Model! { didSet { render(model) } }
  
  @IBOutlet weak var countryImageView: UIImageView!
  @IBOutlet weak var countryLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mainStore.dispatch(CountryArtistsState.Actions.selectCountry(.ukraine))
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    mainStore.subscribe(self) { $0.select(ArtistsListContainerLens.lens) }
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    mainStore.unsubscribe(self)
  }
  
}

// MARK: - store subscriber
extension ArtistsListContainerViewController: StoreSubscriber {
  func newState(state: Country) {
    model = Model(country: state)
  }
}

// MARK: - model supporting
extension ArtistsListContainerViewController: ViewControllerModelSupport {
  func render(_ model: Model) {
    countryImageView.image = UIImage(named: model.country.rawValue)
    countryLabel.text = model.country.rawValue
  }
}
