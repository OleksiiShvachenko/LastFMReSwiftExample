//
//  ArtistTableViewController.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/8/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import UIKit
import ReSwift
import LastFMReduxState

struct ArtistLens: Lens {
  static func lens(_ state: AppState) -> (info: (albums: [Album], artist: Artist?), error: String?) {
    return ((state.artistAlbumsState.albums, state.artistAlbumsState.artist), state.errorState.generalErrorMessage)
  }
  
  static func filter(old: (info: (albums: [Album], artist: Artist?), error: String?),
                     new: (info: (albums: [Album], artist: Artist?), error: String?)) -> Bool {
    return old.info.albums.count == new.info.albums.count && new.error == nil
  }
}

class ArtistTableViewController: UITableViewController {
  
  struct Model: ViewControllerModel {
    let artist: Artist?
    let albums: [Album]
    let error: String?
  }
  
  var model: Model! { didSet { render(model) } }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(AlbumListTableViewCell.nib, forCellReuseIdentifier: AlbumListTableViewCell.identifier)
    tableView.tableFooterView = UIView()
    tableView.estimatedRowHeight = 130
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    mainStore.subscribe(self) { $0.select(ArtistLens.lens) }
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    mainStore.unsubscribe(self)
  }
  
}

// MARK: - TableView
extension ArtistTableViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return model?.albums.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumListTableViewCell.identifier,
                                                   for: indexPath) as? AlbumListTableViewCell else { fatalError() }
    cell.setup(with: model.albums[indexPath.row])
    return cell
  }
  
}

// MARK: - store subscriber
extension ArtistTableViewController: StoreSubscriber {
  func newState(state: (info: (albums: [Album], artist: Artist?), error: String?)) {
    model = Model(artist: state.info.artist, albums: state.info.albums, error: state.error)
  }
}

// MARK: - model supporting
extension ArtistTableViewController: ViewControllerModelSupport, ErrorHandlerController {
  func render(_ model: Model) {
    if let error = model.error {
      show(error: error)
    }
    title = model.artist?.name
    tableView.reloadData()
  }
}
