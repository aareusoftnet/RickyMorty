//
//  LocationVC.swift
//  RickyMorty
//

import UIKit

//MARK: - Class LocationVC
class LocationVC: ParentVC {
    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var viewSearchBarContainer: UIView!
    @IBOutlet weak var txtFieldSearch: UITextField!
    @IBOutlet weak var btnClearTexts: UIButton!
    
    private var pagination = Pagination(pageNumber: 1)
    private var apiLocation = LocationAPI()
    private var arrOfLocations: [LocationVM] = []
    private var isSearching: Bool = false {
        didSet {
            tableView.reloadData()
        }
    }
}

// MARK: UIViewController method(s) & propertie(s)
extension LocationVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        addKeyboardObserver()
        prepareUIs()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        view.endEditing(true)
        if segue.identifier == Segues.characterList {
            let vcCharacterList = segue.destination as! CharacterListVC
            vcCharacterList.location = sender as? LocationVM
        }
    }
}

//MARK: AddObserver(s)
extension LocationVC {
    
    func addObservers() {
        _defaultCenter.addObserver(self, selector: #selector(internetConnectionAvailable(_:)), name: nfInternetAvailable, object: nil)
    }
    
    @objc func internetConnectionAvailable(_ notification: Notification) {
        didRefresh(nil)
    }
    
    func removeObservers() {
        _defaultCenter.removeObserver(self, name: nfInternetAvailable, object: nil)
    }
}

//MARK: UIRelated
extension LocationVC {
    
    /// It will prepare UIs.
    private func prepareUIs() {
        prepareSearchBarUIs()
        registerNIBs()
        configTableViewInsets()
        addPullToRefresh()
        didRefresh(nil)
    }

    /// It will prepare search bar UIs.
    private func prepareSearchBarUIs() {
        prepareSearchFieldUIs()
        hideOrShowClearButton()
    }
    
    /// It will prepare search bar textField UIs.
    private func prepareSearchFieldUIs() {
        txtFieldSearch.setAttributed("~Search location by name".localized, color: .appFFFFFFA80, font: .montserratSemiBold())
        txtFieldSearch.font = .montserratSemiBold(ofSize: 14)
        txtFieldSearch.textColor = .appFFFFFF
        txtFieldSearch.tintColor = .appFFFFFF
        txtFieldSearch.keyboardType = .asciiCapable
        txtFieldSearch.keyboardAppearance = .dark
        txtFieldSearch.autocorrectionType = .no
        txtFieldSearch.returnKeyType = .search
    }
    
    /// It will manage textField text clear button UIs.
    private func hideOrShowClearButton() {
        btnClearTexts.isHidden = txtFieldSearch.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    /// It will register list of NIBs to table view.
    private func registerNIBs() {
        tableView.register(SearchingTVC.nib, forCellReuseIdentifier: SearchingTVC.identifier)
        tableView.register(LoactionListTVC.nib, forCellReuseIdentifier: LoactionListTVC.identifier)
        tableView.register(LoadMoreHFV.nib, forHeaderFooterViewReuseIdentifier: LoadMoreHFV.identifier)
        tableView.register(NoRecordFoundTVC.nib, forCellReuseIdentifier: NoRecordFoundTVC.identifier)
    }
    
    /// It will configure table view instests.
    private func configTableViewInsets() {
        tableView.contentInset = UIEdgeInsets(top: .leastNonzeroMagnitude, left: .leastNonzeroMagnitude, bottom: _defaultBottomInsets, right: .leastNonzeroMagnitude)
    }

    /// It will add pull to refresh control to table view.
    private func addPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .appFFFFFF
        refreshControl.addTarget(self, action: #selector(didRefresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    /// It will handle events when pull to refresh start.
    /// - Parameter refreshControl: It will represent **UIRefreshControl** object.
    @objc func didRefresh(_ refreshControl: UIRefreshControl? = nil) {
        fetchLocations(false, refreshControl: refreshControl)
    }

    /// It will fetch locations based on search texts or default locations.
    /// - Parameters:
    ///   - isLoadMore: It will represent **Bool** value.
    ///   - refreshControl: It will represent **UIRefreshControl** value.
    func fetchLocations(_ isLoadMore: Bool, refreshControl: UIRefreshControl?) {
        if ((isLoadMore == false || refreshControl != nil) && pagination.isLoading == false) {pagination = Pagination(pageNumber: 1)}
        if let searchTerm = txtFieldSearch.text, searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            fetchLocations(searchTerm, refreshControl: refreshControl)
        }else{
            fetchLocations(nil, refreshControl: refreshControl)
        }
    }
}

//MARK: UIButton IBAction(s)
extension LocationVC {
    
    @IBAction func onClearTexts(_ sender: UIButton) {
        isSearching = false
        txtFieldSearch.text = nil
        txtFieldSearch.resignFirstResponder()
        hideOrShowClearButton()
        arrOfLocations = []
        tableView.reloadData()
        didRefresh(nil)
    }
}

//MARK: UITextFieldDelegate
extension LocationVC: UITextFieldDelegate {
    
    @IBAction func textFieldDidChangeText(_ textField: UITextField) {
        isSearching = textField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false
        hideOrShowClearButton()
        didRefresh(nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        isSearching = (pagination.isLoading && textField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false) ? true : false
        return textField.resignFirstResponder()
    }
}

//MARK: UITableView method(s)
extension LocationVC: UITableViewDataSource, UITableViewDelegate {
    
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
        arrOfLocations.isEmpty || isSearching || pagination.isAllLoaded ? .leastNonzeroMagnitude : 60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        arrOfLocations.isEmpty || isSearching || pagination.isAllLoaded ? nil : tableView.dequeueReusableHeaderFooterView(withIdentifier: LoadMoreHFV.identifier)
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if view is LoadMoreHFV {
            let viewLoadMore = view as! LoadMoreHFV
            viewLoadMore.startAnimation()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return 1
        }else if arrOfLocations.isEmpty && isSearching == false && pagination.isLoading == false {
            return 1
        }else{
            return arrOfLocations.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isSearching {
            return 44
        }else if arrOfLocations.isEmpty && isSearching == false {
            return _defaultNoRecordFoundCellHeight
        }else{
            return 20 + 102
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSearching {
            return tableView.dequeueReusableCell(withIdentifier: SearchingTVC.identifier, for: indexPath)
        }else if arrOfLocations.isEmpty && isSearching == false {
            return tableView.dequeueReusableCell(withIdentifier: NoRecordFoundTVC.identifier, for: indexPath)
        }else{
            return tableView.dequeueReusableCell(withIdentifier: LoactionListTVC.identifier, for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is SearchingTVC {
            let cellSearching = cell as! SearchingTVC
            cellSearching.searchTerms = txtFieldSearch.text
        }else if cell is NoRecordFoundTVC {
            let cellNoRecord = cell as! NoRecordFoundTVC
            cellNoRecord.content = "~NO LOCATION FOUNDS WITH SEARCHED TERMS.".localized
        }else if cell is LoactionListTVC {
            let cellLoactionList = cell as! LoactionListTVC
            cellLoactionList.location = arrOfLocations[indexPath.row]
            if indexPath.row == arrOfLocations.count - 1  &&
                pagination.isLoading == false &&
                pagination.isAllLoaded == false {
                fetchLocations(true, refreshControl: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrOfLocations.isEmpty == false {
            performSegue(withIdentifier: Segues.characterList, sender: arrOfLocations[indexPath.row])
        }
    }
    
    /// It will scroll table view to top position.
    func scrollToTop() {
        if arrOfLocations.isEmpty == false {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
}

//MARK: Other(s)
extension LocationVC {
    
    /// It will fetch list of trending giphies.
    /// - Parameters:
    ///   - isIndicatorShow: It will represent Bool value to handle indicator is visible or not.
    ///   - refreshControl: It will represent UIRefreshControl object value.
    func fetchLocations(_ searchTerms: String?, refreshControl: UIRefreshControl?) {
        if APIClient.isInternetAvailable && pagination.isLoading == false {
            if arrOfLocations.isEmpty && isSearching == false {showIndicatorInCenter()}
            pagination.isLoading = true
            apiLocation.fetchLocations(searchTerms, pagination: pagination) {[weak self](locations, message) in
                guard let self = self else{return}
                refreshControl?.endRefreshing()
                self.hideIndicatorFromCenter()
                if self.pagination.pageNumber == 1 {self.arrOfLocations = []}
                self.pagination.isLoading = false
                self.isSearching = false
                if let message = message {
                    vPrint(#function + " : " + message)
                }else if let locations = locations {
                    self.pagination.increase(1)
                    self.arrOfLocations.append(contentsOf: locations)
                    self.tableView.reloadData()
                    vPrint(#function + " : \(self.arrOfLocations.count)")
                }
            }
        }
    }
}
