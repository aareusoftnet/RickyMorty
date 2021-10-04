//
//  NavigationBar.swift
//  RickyMorty
//

import UIKit

//MARK: - Struct NavigationConfig
class NavigationConfig {
    var leftButtonImage = UIImage(named: "iconClose")
    var leftButtonTitle: String? = nil
    var rightButtonImage: UIImage? = nil
    var rightButtonTitle: String? = nil
    var strTitle: NSAttributedString?
    var titleTextColor: UIColor = .appFFFFFF
    var titleFont: UIFont = .montserratSemiBold(ofSize: 16)
    var isTitleHidden = false
    var isLeftViewHidden = true
    var isRightViewHidden = true
    var isSeparatorViewHidden = false
    var leftViewAction: NavigationAction = .popController
    var rightViewAction: NavigationAction = .dismissController
}

//MARK: - Enum NavigationAction
enum NavigationAction: Int {
    case popController = 0 //Pop to previous screen
    case dismissController = 1 //Dismiss to previous screen
    case openFilters = 2 // Open favourites
}

//MARK: - Class NavigationBarContainer
class NavigationBarContainer: ParentView {
    
    @IBInspectable private var isLeftViewHidden: Bool {
        get {return objNavigationConfig.isLeftViewHidden}
        set {objNavigationConfig.isLeftViewHidden = newValue}
    }
    
    @IBInspectable private var leftButtonImage: UIImage? {
        get {return objNavigationConfig.leftButtonImage}
        set{objNavigationConfig.leftButtonImage = newValue}
    }
    
    @IBInspectable private var leftButtonTitle: String? {
        get {return objNavigationConfig.leftButtonTitle}
        set{objNavigationConfig.leftButtonTitle = newValue}
    }
    
    @IBInspectable private var isRightViewHidden: Bool {
        get {return objNavigationConfig.isRightViewHidden}
        set {objNavigationConfig.isRightViewHidden = newValue}
    }
    
    @IBInspectable private var isSeparatorViewHidden: Bool {
        get {return objNavigationConfig.isSeparatorViewHidden}
        set {objNavigationConfig.isSeparatorViewHidden = newValue}
    }

    @IBInspectable private var rightButtonImage: UIImage? {
        get {return objNavigationConfig.rightButtonImage}
        set{objNavigationConfig.rightButtonImage = newValue}
    }
    
    @IBInspectable private var rightButtonTitle: String? {
        get {return objNavigationConfig.rightButtonTitle}
        set {objNavigationConfig.rightButtonTitle = newValue}
    }
    
    @IBInspectable private var isTitleHidden: Bool {
        get {return objNavigationConfig.isTitleHidden}
        set {objNavigationConfig.isTitleHidden = newValue}
    }
    
    @IBInspectable private var title: NSAttributedString? {
        get {return objNavigationConfig.strTitle}
        set {objNavigationConfig.strTitle = newValue}
    }
    
    @IBInspectable private var titleColor: UIColor {
        get { return objNavigationConfig.titleTextColor }
        set { objNavigationConfig.titleTextColor = newValue }
    }
    
    @IBInspectable private var leftViewAction: Int {
        get {return objNavigationConfig.leftViewAction.rawValue}
        set {objNavigationConfig.leftViewAction = NavigationAction(rawValue: newValue)!}
    }
    
    @IBInspectable private var rightViewAction: Int {
        get {return objNavigationConfig.rightViewAction.rawValue}
        set {objNavigationConfig.rightViewAction = NavigationAction(rawValue: newValue)!}
    }
    
    var navigationBlock: NavigationBlock?
    var objNavigationConfig = NavigationConfig()
    var viewNavigationBar: NavigationBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Initialise navigation bar
        viewNavigationBar = NavigationBar.instantiateViewFromNib(objNavigationConfig)
        
        //Navigation bar, add to subview.
        addSubview(viewNavigationBar)
        //Define constraints
        let top = NSLayoutConstraint(item: viewNavigationBar!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: viewNavigationBar!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        let trail = NSLayoutConstraint(item: viewNavigationBar!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        let lead = NSLayoutConstraint(item: viewNavigationBar!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        //Add constraints to navigationBar
        viewNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([top, bottom, trail, lead])
    }
    
    func actionHandlerWith(_ actionBlock: @escaping NavigationBlock) {
        viewNavigationBar.navigationBlock = actionBlock
        navigationBlock = viewNavigationBar.navigationBlock
    }
}

typealias NavigationBlock = (_ navigationBar: NavigationBar, _ navigationAction: NavigationAction, _ button: UIButton) -> ()

//MARK: - Class NavigationBar
class NavigationBar: ParentView {
    @IBOutlet weak private var btnRight: UIButton!
    @IBOutlet weak private var btnLeft: UIButton!
    @IBOutlet weak private var lblTitle: UILabel!
    @IBOutlet weak private var lblSeparator: UILabel!
    fileprivate var objNavigationConfig: NavigationConfig!
    fileprivate var navigationBlock: NavigationBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func instantiateViewFromNib(_ navigationConfig : NavigationConfig) -> NavigationBar {
        let viewNavigationBar = Bundle.main.loadNibNamed("NavigationBar", owner: nil, options: nil)![0] as! NavigationBar
        viewNavigationBar.objNavigationConfig = navigationConfig
        viewNavigationBar.prepareUIs()
        return viewNavigationBar
    }
    
    func prepareUIs() {
        //Navigation left UIs.
        btnLeft.isHidden = objNavigationConfig.isLeftViewHidden
        btnLeft.contentVerticalAlignment = .center
        btnLeft.contentHorizontalAlignment = .left
        if let btnLeftImage = objNavigationConfig.leftButtonImage {btnLeft.setImage(btnLeftImage, for: .normal)}
        if let btnLeftTitle = objNavigationConfig.leftButtonTitle {btnLeft.setTitle(btnLeftTitle, for: .normal)}
        //Navigation center UIs.
        lblTitle.numberOfLines = 0
        lblTitle.adjustsFontSizeToFitWidth = true
        lblTitle.isHidden = objNavigationConfig.isTitleHidden
        lblTitle.attributedText = objNavigationConfig.strTitle
        lblTitle.textColor = objNavigationConfig.titleTextColor
        lblTitle.font = objNavigationConfig.titleFont
        //Navigation right UIs.
        btnRight.isHidden = objNavigationConfig.isRightViewHidden
        btnRight.contentVerticalAlignment = .center
        btnRight.contentHorizontalAlignment = .right
        if let btnRightImage = objNavigationConfig.rightButtonImage {btnRight.setImage(btnRightImage, for: .normal)}
        if let btnRightTitle = objNavigationConfig.rightButtonTitle {btnRight.setTitle(btnRightTitle, for: .normal)}
        lblSeparator.isHidden = objNavigationConfig.isSeparatorViewHidden
    }
    
    @IBAction func onLeftViewTapped(_ sender: UIButton) {
        DispatchQueue.main.async{self.navigationBlock?(self, self.objNavigationConfig.leftViewAction, sender)}
    }
    
    @IBAction func onRightViewTapped(_ sender: UIButton) {
        DispatchQueue.main.async {self.navigationBlock?(self, self.objNavigationConfig.rightViewAction, sender)}
    }
}
