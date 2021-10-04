//
//  EpisodeListTVC.swift
//  RickyMorty
//

import UIKit

//MARK: - Class EpisodeListTVC
class EpisodeListTVC: ParentTVC {
    @IBOutlet weak var lblEpisode: UILabel!
    @IBOutlet weak var lblEpisodeName: UILabel!
    @IBOutlet weak var viewStackAirDateCharacter: UIStackView!
    @IBOutlet weak var lblAirDate: UILabel!
    @IBOutlet weak var lblCharacters: UILabel!
    var episode: EpisodeVM? {
        didSet {
            prepareUIs()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUIs()
    }
}

//MARK: UIRelated
extension EpisodeListTVC {
    
    /// It will prepare EpisodeList data.
    private func prepareUIs() {
        if let episode = episode {
            lblEpisode.text = episode.title
            lblEpisodeName.text = episode.name
            lblAirDate.text = episode.airDate
            lblCharacters.text = episode.displayCharactersCount
        }
    }
}
