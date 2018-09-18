//
//  ArtistsListTableViewController.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import UIKit
import ReSwift
import LastFMReduxState

class ArtistsListTableViewController: UITableViewController {
    
    struct Model: ViewControllerModel {
        let artists: [Artist]
        let error: String?
    }
    
    var model: Model! { didSet { render(model) } }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ArtistTableViewCell.nib, forCellReuseIdentifier: ArtistTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 130
        tableView.rowHeight = UITableView.automaticDimension
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

// MARK: - TableView
extension ArtistsListTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.artists.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.identifier,
                                                       for: indexPath) as? ArtistTableViewCell else { fatalError() }
        cell.setup(with: model.artists[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainStore.dispatch(CountryArtistsState.ActionCreators.didTapOnArtist(at: indexPath.row))
        guard let controller = AppStoryboard.artist.initialViewController else { fatalError() }
        navigationController?.show(controller, sender: nil)
    }
}

// MARK: - store subscriber
extension ArtistsListTableViewController: StoreSubscriber {
    func newState(state: (artists: [Artist], error: String?)) {
        model = Model(artists: state.artists, error: state.error)
    }
}

// MARK: - model supporting
extension ArtistsListTableViewController: ViewControllerModelSupport, ErrorHandlerController {
    func render(_ model: Model) {
        show(error: model.error)
        tableView.reloadData()
    }
}
