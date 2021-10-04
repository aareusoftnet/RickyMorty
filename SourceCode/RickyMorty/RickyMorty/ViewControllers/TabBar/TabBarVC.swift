//
//  TabBarVC.swift
//  RickyMorty
//

import UIKit

//MARK: - Class TabBarVC
class TabBarVC: UITabBarController {
    var viewTabBar: TabBarView!
    lazy var vcEpisode: EpisodeVC = {
        return children[0] as! EpisodeVC
    }()
    lazy var vcLocation: LocationVC = {
        return children[1] as! LocationVC
    }()
    
    deinit{
        vPrint("Deallocated: \(self.classForCoder)")
    }
}

// MARK: UIViewController method(s) & propertie(s)
extension TabBarVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUIs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBar.bringSubviewToFront(viewTabBar)
    }
}

// MARK: UIRelated
extension TabBarVC {
    
    private func prepareUIs() {
        loadTabBarView()
        selectedIndex = 0
        tabBar.backgroundColor = .clear
    }
    
    private func loadTabBarView() {
        guard viewTabBar == nil else { return }
        viewTabBar = Bundle.main.loadNibNamed("TabBarView", owner: self, options: nil)![0] as?
            TabBarView
        viewTabBar.delegate = self
        viewTabBar.frame = CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: tabBar.frame.size.height)
        tabBar.clipsToBounds = true
        tabBar.addSubview(viewTabBar)
        tabBar.layoutIfNeeded()
    }
}

// MARK: TabBarDelegate
extension TabBarVC: TabBarDelegate {
    
    func didTapOnTab(_ option: TabBarOption?) {
        guard let option = option else { return }
        if option.rawValue == selectedIndex {
            option == .episode ? vcEpisode.scrollToTop() : vcLocation.scrollToTop()
        }
        selectedIndex = option.rawValue
    }
}
