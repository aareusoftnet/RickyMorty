//
//  TabBarView.swift
//  RickyMorty
//

import UIKit

//MARK: - Enum TabBarOption
enum TabBarOption: Int {
    case episode = 0
    case location = 1
}

//MARK: - Protocol TabBarDelegate
protocol TabBarDelegate: AnyObject {
    func didTapOnTab(_ option: TabBarOption?)
}

// MARK: - Class TabBarView
class TabBarView: ParentView {
    @IBOutlet weak var viewTabBarContainer: UIStackView!
    @IBOutlet weak var viewEpisodeStack: UIView!
    @IBOutlet weak var viewEpisode: UIView!
    @IBOutlet weak var btnEpisode: UIButton!
    @IBOutlet weak var lblEpisode: UILabel!
    @IBOutlet weak var viewLocationStack: UIView!
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var lblLocation: UILabel!

    
    var selectedTab: TabBarOption = .episode
    weak var delegate: TabBarDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateTabUI()
    }
}

// MARK: UIRelated
extension TabBarView {
    
    /// It will prepare default state UIs.
    private func prepareDefaultUIs() {
        viewTabBarContainer.spacing = 110 * AppConfig.widthRatio
        btnEpisode.tintColor = .appFFFFFFA20
        lblEpisode.text = "~Episode".localized
        lblEpisode.textColor = .appFFFFFFA20

        btnLocation.tintColor = .appFFFFFFA20
        lblLocation.text = "~Location".localized
        lblLocation.textColor = .appFFFFFFA20
    }
    
    /// It will update TabUIs.
    private func updateTabUI() {
        prepareDefaultUIs()
        switch selectedTab {
            case .episode:
                btnEpisode.tintColor = .appFF4C00
                lblEpisode.textColor = .appFF4C00
            case .location:
                btnLocation.tintColor = .appFF4C00
                lblLocation.textColor = .appFF4C00
        }
    }
}

// MARK: IBAction(s)
extension TabBarView {
    
    @IBAction func btnTabTap(_ sender: UIButton) {
        selectedTab = TabBarOption(rawValue: sender.tag)!
        updateTabUI()
        delegate?.didTapOnTab(selectedTab)
    }
}
