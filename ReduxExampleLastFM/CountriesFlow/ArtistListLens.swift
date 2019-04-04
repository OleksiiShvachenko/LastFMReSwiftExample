//
//  ArtistListLens.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import Foundation
import LastFMReduxState

struct ArtistsListLens: Lens {
    static func lens(_ state: AppState) -> (artists: [Artist], error: String?) {
        return (state.artistsState.artists ?? [], nil)
    }
    
    static func filter(old: (artists: [Artist], error: String?), new: (artists: [Artist], error: String?)) -> Bool {
        return old.artists.count == new.artists.count && new.error == nil
    }
}
