//
//  CharacterDetailsVC.swift
//  RickyMorty
//

import UIKit

//MARK: - Class CharacterDetailsVC
class CharacterDetailsVC: ParentVC {
    private var arrOfInfoTypes: [CharacterInfoTypes] {
        return [
            CharacterInfoTypes.staus(characterDetails.status),
            CharacterInfoTypes.species(characterDetails.species),
            CharacterInfoTypes.gender(characterDetails.gender),
            CharacterInfoTypes.type(characterDetails.displayType),
            CharacterInfoTypes.origin(characterDetails.origin),
            CharacterInfoTypes.lastLocation(characterDetails.lastLocation),
        ]
    }
    //Carried variable(s)
    var characterDetails: CharacterVM!
}

// MARK: UIViewController method(s) & propertie(s)
extension CharacterDetailsVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUIs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

//MARK: UIRelated
extension CharacterDetailsVC {
    
    /// It will prepare UIs.
    private func prepareUIs() {
        prepareNavigationBarUIs()
        registerNIBs()
    }
    
    /// It will prepare navigation bar UIs.
    private func prepareNavigationBarUIs() {
        configNavigationBarTitleUIs()
        configNavigationBarRightUIs()
        configNavigationSeparatorUIs()
        viewNavigationBar?.viewNavigationBar.prepareUIs()
    }

    /// It will prepare navigation bar title UIs.
    private func configNavigationBarTitleUIs() {
        viewNavigationBar?.objNavigationConfig.strTitle = characterDetails.name.setString(.center, textFont: .montserratSemiBold(ofSize: 16), foregroundColor: .appFFFFFF)
        
    }
    
    /// It will prepare navigation bar right UIs.
    private func configNavigationBarRightUIs() {
        viewNavigationBar?.objNavigationConfig.isRightViewHidden = false
        viewNavigationBar?.objNavigationConfig.rightButtonImage = .imgClose
    }
    
    /// It will prepare navigation bar right UIs.
    private func configNavigationSeparatorUIs() {
        viewNavigationBar?.objNavigationConfig.isSeparatorViewHidden = true
    }

    /// It will register list of NIBs to table view.
    private func registerNIBs() {
        tableView.register(CharacterImageHFV.nib, forHeaderFooterViewReuseIdentifier: CharacterImageHFV.identifier)
        tableView.register(CharacterInfoTVC.nib, forCellReuseIdentifier: CharacterInfoTVC.identifier)
    }
}

//MARK: UITableView method(s)
extension CharacterDetailsVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        AppConfig.width
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.dequeueReusableHeaderFooterView(withIdentifier: CharacterImageHFV.identifier)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let viewHeader = view as! CharacterImageHFV
        viewHeader.imgURL = characterDetails.imageURL
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrOfInfoTypes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: CharacterInfoTVC.identifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is CharacterInfoTVC {
            let cellCharacterInfo = cell as! CharacterInfoTVC
            cellCharacterInfo.type = arrOfInfoTypes[indexPath.row]
        }
    }
}
