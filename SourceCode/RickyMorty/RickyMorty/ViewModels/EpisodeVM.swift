//
//  EpisodeVM.swift
//  RickyMorty
//

import Foundation

/**
 EpisodeVM struct used to display it's value on UIs part.
 ### Properties
 - **id**: The id of the episode.
 - **title**: The title of the episode.
 - **name**: The name of the episode.
 - **airDate**: The air date of the episode.
 - **characters**: List of characters who have been seen in the episode.
 */
struct EpisodeVM {
    var id: Int
    var title: String
    var name: String
    var airDate: String
    var characters: [String]
    var displayCharactersCount: String {
        if characters.isEmpty {
            return "~No character".localized
        }else if characters.count == 1 {
            return characters.count.description + "~Character".localized
        }else {
            return characters.count.description + "~Characters".localized
        }
    }
    /// It will initialized object from **Episode** model
    /// - Parameter giphy: It will represent **Episode** object value.
    init(_ episode: Episode) {
        id = episode.id
        title = episode.episode
        name = episode.name
        airDate = episode.airDate
        characters = episode.characters
    }
}
