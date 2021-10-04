//
//  CharacterFilterView.swift
//  RickyMorty
//

import UIKit

//MARK: - Enum UserActionType
enum UserActionType {
    case dismiss
    case clearAll
    case apply
}

//MARK: - Typealias UserActionBlock
typealias UserActionBlock = ((_ anyObject: Any?, _ userActionType: UserActionType, _ view: UIView?) -> ())

//MARK: - Class CharacterFilterView
class CharacterFilterView: ParentView {
    @IBOutlet weak var viewBackground: UIVisualEffectView!
    @IBOutlet weak var viewActionSheet: UIView!
    @IBOutlet weak var viewTopBar: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var viewLeftContainer: UIView!
    @IBOutlet weak var viewVStackLeft: UIStackView!
    @IBOutlet weak var viewStatusContainer: UIView!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var viewHStackStatus: UIStackView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var viewGenderContainer: UIView!
    @IBOutlet weak var btnGender: UIButton!
    @IBOutlet weak var viewHStackGender: UIStackView!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewBottomBar: UIView!
    @IBOutlet weak var viewStackBottomBar: UIStackView!
    @IBOutlet weak var btnClearAll: UIButton!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var viewBottomLayout: UIView!
    @IBOutlet weak var constraintBottomActionSheet: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightActionSheet: NSLayoutConstraint!
    var actionBlock: UserActionBlock?
    
    private let fixedTotalHeight: CGFloat = 400 + AppConfig.safeAreaInsets.bottom
    private var statusFilter: CharacterFilterVM!
    private var genderFilter: CharacterFilterVM!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareDefaultUIs()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyCornerRadius()
    }

    deinit {
        vPrint("Deallocated: \(self.classForCoder)")
    }
}

//MARK: Initialise
extension CharacterFilterView {
    
    /// It will show confirm safety action sheet.
    @discardableResult class func showIn(_ view: UIView, selectedFilter: CharacterFilter?, actionBlock: UserActionBlock?) -> CharacterFilterView {
        let viewCharacterFilter = UINib(nibName: "CharacterFilterView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CharacterFilterView
        viewCharacterFilter.frame = view.frame
        viewCharacterFilter.actionBlock = actionBlock
        viewCharacterFilter.initModels(selectedFilter)
        viewCharacterFilter.prepareUIs()
        viewCharacterFilter.prepareLeftContainerUIs()
        view.addSubview(viewCharacterFilter)
        viewCharacterFilter.layoutIfNeeded()
        viewCharacterFilter.present(0.20, completion: nil)
        return viewCharacterFilter
    }
}

//MARK: UIRelated
extension CharacterFilterView {
    
    /// It will prepare default UIs.
    private func prepareDefaultUIs() {
        frame = CGRect(x: 0, y: 0, width: AppConfig.width, height: AppConfig.height)
        constraintHeightActionSheet.constant = fixedTotalHeight
        constraintBottomActionSheet.constant = -fixedTotalHeight
        viewBackground.alpha = 0.0
    }
    
    /// It wil initialize the models.
    private func initModels(_ selectedFilter: CharacterFilter?) {
        if let selectedFilter = selectedFilter {
            statusFilter = selectedFilter.statusFilter
            genderFilter = selectedFilter.genderFilter
        }else{
            statusFilter = CharacterFilterVM(.status, isSelected: true, selectedOption: nil)
            genderFilter = CharacterFilterVM(.gender, isSelected: false, selectedOption: nil)
        }
    }
    
    /// It will apply corner radius to action sheet UIs.
    private func applyCornerRadius() {
        let path = UIBezierPath(roundedRect: viewActionSheet.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 25, height: 25))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = viewActionSheet.bounds
        maskLayer.path = path.cgPath
        viewActionSheet.layer.mask = maskLayer
    }
    
    /// It will prepare UIs from data.
    private func prepareUIs() {
        prepareBottomBarUIs()
        prepareTopBarUIs()
        prepareLeftContainerDefaultUIs()
        registerNIBs()
    }
    
    /// It will prepare top bar UIs.
    private func prepareTopBarUIs() {
        lblTitle.attributedText = "~Filter By".localized.setString(.natural, lineBreakMode: .byTruncatingTail, textFont: .montserratBold(ofSize: 16), foregroundColor: .appFFFFFF)
    }
    
    /// It will prepare left container default UIs.
    private func prepareLeftContainerDefaultUIs() {
        lblStatus.attributedText = statusFilter.filterOption.title
        lblGender.attributedText = genderFilter.filterOption.title
    }
    
    /// It will preapare left container UIs based on user selection.
    private func prepareLeftContainerUIs() {
        if statusFilter.isSelected {
            viewStatusContainer.alpha = 1.0
            viewGenderContainer.alpha = 0.5
        }else if genderFilter.isSelected {
            viewGenderContainer.alpha = 1.0
            viewStatusContainer.alpha = 0.5
        }
        tableView.reloadData()
    }
    
    /// It will register list of NIBs to table view.
    private func registerNIBs() {
        tableView.register(CharacterFilterOptionListTVC.nib, forCellReuseIdentifier: CharacterFilterOptionListTVC.identifier)
    }

    /// It will prepare bottom bar UIs.
    private func prepareBottomBarUIs() {
        btnClearAll.layer.borderWidth = 1
        btnClearAll.layer.borderColor = UIColor.app0D0D0D.cgColor
        btnClearAll.cornerRadius = 8
        btnClearAll.clipsToBounds = true
        btnClearAll.setAttributedTitle("~Clear All".localized.setString(.natural, lineBreakMode: .byTruncatingTail, textFont: .montserratBold(ofSize: 16), foregroundColor: .app0D0D0D), for: .normal)
        
        btnApply.cornerRadius = 8
        btnApply.clipsToBounds = true
        btnApply.backgroundColor = .appFF4C00
        btnApply.setAttributedTitle("~Apply".localized.setString(.natural, lineBreakMode: .byTruncatingTail, textFont: .montserratBold(ofSize: 16), foregroundColor: .appFFFFFF), for: .normal)
    }
}

//MARK: - IBAction(s)
extension CharacterFilterView {
    
    @IBAction func onDismissTap(_ sender: UIButton) {
        dismiss(0.1, delay: 0.0) {[weak self] in
            guard let self = self else{return}
            self.actionBlock?(nil, .dismiss, self)
        }
    }
    
    @IBAction func onStatusFilterTap(_ sender: UIButton) {
        statusFilter.isSelected = true
        genderFilter.isSelected = false
        prepareLeftContainerUIs()
    }

    @IBAction func onGenderFilterTap(_ sender: UIButton) {
        genderFilter.isSelected = true
        statusFilter.isSelected = false
        prepareLeftContainerUIs()
    }
    
    @IBAction func onClearAllTap(_ sender: UIButton) {
        initModels(nil)
        dismiss(0.1, delay: 0.0) {[weak self] in
            guard let self = self else{return}
            self.actionBlock?(CharacterFilter(self.statusFilter, genderFilter: self.genderFilter), .clearAll, self)
        }
    }

    @IBAction func onApplyTap(_ sender: UIButton) {
        dismiss(0.1, delay: 0.0) {[weak self] in
            guard let self = self else{return}
            self.actionBlock?(CharacterFilter(self.statusFilter, genderFilter: self.genderFilter), .apply, self)
        }
    }
}

//MARK: - Animation
extension CharacterFilterView {
    
    func present(_ duration: TimeInterval, completion: (() -> ())?) {
        constraintBottomActionSheet.constant = 0
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.viewBackground.alpha = 1.0
            self.layoutIfNeeded()
        }, completion: { (completed) -> Void in
            completion?()
        })
    }
    
    func dismiss(_ duration: TimeInterval, delay: TimeInterval, completion: (() -> ())?) {
        constraintBottomActionSheet.constant = -fixedTotalHeight
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.viewBackground.alpha = 0.0
            self.layoutIfNeeded()
        }, completion: { (completed) -> Void in
            completion?()
        })
    }
}

//MARK: UITableView method(s)
extension CharacterFilterView: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        statusFilter.isSelected ? statusFilter.allOptions.count : genderFilter.allOptions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        20 + 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: CharacterFilterOptionListTVC.identifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is CharacterFilterOptionListTVC {
            let cellCharacterFilterOptionList = cell as! CharacterFilterOptionListTVC
            if statusFilter.isSelected {
                cellCharacterFilterOptionList.prepareUIs(statusFilter.allOptions[indexPath.row], selectedOption: statusFilter.selectedOption)
            }else if genderFilter.isSelected {
                cellCharacterFilterOptionList.prepareUIs(genderFilter.allOptions[indexPath.row], selectedOption: genderFilter.selectedOption)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if statusFilter.isSelected {
            statusFilter.selectedOption = statusFilter.allOptions[indexPath.row]
        }else if genderFilter.isSelected {
            genderFilter.selectedOption = genderFilter.allOptions[indexPath.row]
        }
        tableView.reloadData()
    }
    
    /// It will scroll table view to top position.
    func scrollToTop() {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}
