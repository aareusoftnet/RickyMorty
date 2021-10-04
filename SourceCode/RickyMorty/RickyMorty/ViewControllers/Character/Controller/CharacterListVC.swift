//
//  CharacterListVC.swift
//  RickyMorty
//

import UIKit

//MARK: - Class CharacterListVC
class CharacterListVC: ParentVC {
    private var characterFilter: CharacterFilter?
    private var apiCharacter = CharacterAPI()
    private var arrOfAllCharacterDetails: [CharacterDetailVM] = []
    private var arrOfCharacterDetails: [CharacterDetailVM] = []
    //Carried variable(s)
    var episode: EpisodeVM?
    var location: LocationVM?
}

// MARK: UIViewController method(s) & propertie(s)
extension CharacterListVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initModels()
        prepareUIs()
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        view.endEditing(true)
        if segue.identifier == Segues.characterDetail {
            let vcCharacterDetails = segue.destination as! CharacterDetailsVC
            vcCharacterDetails.characterDetails = sender as? CharacterVM
        }
    }
    
    override func navigationBarHandler() {
        viewNavigationBar?.actionHandlerWith({[weak self](navigationBar, navigationAction, tapButton) in
            guard let self = self else{return}
            switch navigationAction {
                case .popController:
                    self.navigationController?.popViewController(animated: true)
                case .openFilters:
                    self.showFilterUIs()
                    break
                default: break
            }
        })
    }
}

//MARK: AddObserver(s)
extension CharacterListVC {
    
    func addObservers() {
        _defaultCenter.addObserver(self, selector: #selector(internetConnectionAvailable(_:)), name: nfInternetAvailable, object: nil)
    }
    
    @objc func internetConnectionAvailable(_ notification: Notification) {
        tableView.reloadData()
    }
    
    func removeObservers() {
        _defaultCenter.removeObserver(self, name: nfInternetAvailable, object: nil)
    }
}

//MARK: UIRelated
extension CharacterListVC {
    
    /// It will initialise the models.
    private func initModels() {
        if let episode = episode {
            episode.characters.forEach { character in
                guard let vmCharacterDetail = CharacterDetailVM(false, urlEndPoint: character) else{return}
                arrOfAllCharacterDetails.append(vmCharacterDetail)
            }
        }else if let location = location {
            location.residents.forEach { resident in
                guard let vmCharacterDetail = CharacterDetailVM(false, urlEndPoint: resident) else{return}
                arrOfAllCharacterDetails.append(vmCharacterDetail)
            }
        }
        
        arrOfCharacterDetails = arrOfAllCharacterDetails
    }
    
    /// It will prepare UIs.
    private func prepareUIs() {
        prepareNavigationBarUIs()
        registerNIBs()
    }
    
    /// It will prepare navigation bar UIs.
    private func prepareNavigationBarUIs() {
        configNavigationBarLeftUIs()
        configNavigationBarTitleUIs()
        configNavigationBarRightUIs()
        viewNavigationBar?.viewNavigationBar.prepareUIs()
    }
    
    /// It will prepare navigation bar right UIs.
    private func configNavigationBarLeftUIs() {
        viewNavigationBar?.objNavigationConfig.isLeftViewHidden = false
        viewNavigationBar?.objNavigationConfig.leftButtonImage = .imgBack
    }
    
    /// It will prepare navigation bar title UIs.
    private func configNavigationBarTitleUIs() {
        if let episode = episode {
            viewNavigationBar?.objNavigationConfig.strTitle = episode.name.setString(.center, textFont: .montserratSemiBold(ofSize: 16), foregroundColor: .appFFFFFF)
        }else if let location = location {
            viewNavigationBar?.objNavigationConfig.strTitle = location.name.setString(.center, textFont: .montserratSemiBold(ofSize: 16), foregroundColor: .appFFFFFF)
        }
    }
    
    /// It will prepare navigation bar right UIs.
    private func configNavigationBarRightUIs() {
        viewNavigationBar?.objNavigationConfig.isRightViewHidden = false
        viewNavigationBar?.objNavigationConfig.rightViewAction = .openFilters
        viewNavigationBar?.objNavigationConfig.rightButtonImage = .imgFilter
    }
    
    /// It will register list of NIBs to table view.
    private func registerNIBs() {
        tableView.register(NoRecordFoundTVC.nib, forCellReuseIdentifier: NoRecordFoundTVC.identifier)
        tableView.register(CharacterListTVC.nib, forCellReuseIdentifier: CharacterListTVC.identifier)
    }
    
    /// It will open filter selection UIs.
    private func showFilterUIs() {
        CharacterFilterView.showIn(view, selectedFilter: characterFilter) { [weak self] (anyObject, userActionType, characterFilterView) in
            guard let self = self else{return}
            switch userActionType {
                case .dismiss:
                    break
                case .clearAll:
                    self.characterFilter = nil
                    self.filterCharacters()
                case .apply:
                    self.characterFilter = anyObject as? CharacterFilter
                    self.filterCharacters()
            }
            characterFilterView?.removeFromSuperview()
        }
    }
}

//MARK: UITableView method(s)
extension CharacterListVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrOfCharacterDetails.isEmpty ? 1 : arrOfCharacterDetails.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        arrOfCharacterDetails.isEmpty ? _defaultNoRecordFoundCellHeight : 20 + 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: arrOfCharacterDetails.isEmpty ? NoRecordFoundTVC.identifier : CharacterListTVC.identifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is NoRecordFoundTVC {
            let cellNoRecordFound = cell as! NoRecordFoundTVC
            cellNoRecordFound.content = "~NO CHARACTER FOUNDS WITH APPLIED FILTERS.".localized
        }else if cell is CharacterListTVC {
            let details = arrOfCharacterDetails[indexPath.row]
            let cellCharacterList = cell as! CharacterListTVC
            cellCharacterList.prepareUIs(details)
            if details.isLoaded == false {
                fetchCharacter(arrOfCharacterDetails[indexPath.row])
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrOfCharacterDetails.isEmpty == false {
            let details = arrOfCharacterDetails[indexPath.row]
            if details.isLoaded {
                performSegue(withIdentifier: Segues.characterDetail, sender: details.details)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        if arrOfCharacterDetails.isEmpty == false && arrOfCharacterDetails[indexPath.row].isLoaded {
            let sbCharacter = UIStoryboard(name: "Character", bundle: nil)
            let previewProvider: () -> CharacterDetailsVC = { [unowned self] in
                let vcDetails = sbCharacter.instantiateViewController(identifier: "CharacterDetailsVC")  as! CharacterDetailsVC
                vcDetails.characterDetails = arrOfCharacterDetails[indexPath.row].details
                return vcDetails
            }
            
            let actionProvider: ([UIMenuElement]) -> UIMenu? = { [weak self] _ in
                guard let self = self else{return nil}
                var arrOfMenuElement: [UIMenuElement] = []
                let shareMenu = UIAction(title: "~Share".localized, image: UIImage(systemName: "square.and.arrow.up"), identifier: UIAction.Identifier(rawValue: "share")) {[weak self] _ in
                    guard let self = self else{return}
                    DispatchQueue.main.async {self.openShareKit(self.arrOfCharacterDetails[indexPath.item].details!)}
                }
                arrOfMenuElement.append(shareMenu)
                return UIMenu(title: "", image: nil, identifier: nil, children: arrOfMenuElement)
            }
            return UIContextMenuConfiguration(identifier: nil, previewProvider: previewProvider, actionProvider: actionProvider)
        }else{
            return nil
        }
    }
}

//MARK: Other(s)
extension CharacterListVC {
    
    /// It will fetch list of trending giphies.
    /// - Parameters:
    ///   - isIndicatorShow: It will represent Bool value to handle indicator is visible or not.
    ///   - refreshControl: It will represent UIRefreshControl object value.
    func fetchCharacter(_ detail: CharacterDetailVM) {
        if APIClient.isInternetAvailable {
            apiCharacter.fetchCharacter(detail, completionBlock: {[weak self](character, message) in
                guard let self = self else{return}
                if let message = message {
                    vPrint(#function + " : " + message)
                }else if let character = character {
                    detail.update(character)
                    self.tableView.reloadData()
                    vPrint(#function + " : \(detail.debugDescription)")
                }
            })
        }
    }
    
    /// It is used to filter the data based on user's options.
    func filterCharacters() {
        if let characterFilter = characterFilter {
            arrOfCharacterDetails = arrOfAllCharacterDetails.filter({ [weak self] (characterDetail) in
                guard let _ = self else{return false}
                guard let characterDetails = characterDetail.details, characterDetail.isLoaded else{return false}
                if let selectedGenderFilter = characterFilter.genderFilter.selectedOption as? CharacterGenderType,
                   let selectedStatusFilter = characterFilter.statusFilter.selectedOption as? CharacterStatusType {
                    return characterDetails.gender == selectedGenderFilter && characterDetails.status == selectedStatusFilter
                }else if let selectedGenderFilter = characterFilter.genderFilter.selectedOption as? CharacterGenderType {
                    return characterDetails.gender == selectedGenderFilter
                }else if let selectedStatusFilter = characterFilter.statusFilter.selectedOption as? CharacterStatusType {
                    return characterDetails.status == selectedStatusFilter
                }else{
                    return true
                }
            })
        }else{
            arrOfCharacterDetails = arrOfAllCharacterDetails
        }
        tableView.reloadData()
    }
}
