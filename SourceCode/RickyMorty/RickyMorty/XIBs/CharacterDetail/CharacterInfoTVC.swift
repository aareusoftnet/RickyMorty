//
//  CharacterInfoTVC.swift
//  RickyMorty
//

import UIKit

//MARK: - Class CharacterInfoTVC
class CharacterInfoTVC: ParentTVC {
    @IBOutlet weak var viewStackContainer: UIStackView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var imgVwStatus: UIImageView!
    @IBOutlet weak var constraintStatusHeight: NSLayoutConstraint!
    var type: CharacterInfoTypes? {
        didSet {
            prepareUIs()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

//MARK: UIRelated
extension CharacterInfoTVC {
    
    /// It will prepare LocationList data.
    func prepareUIs() {
        if let infoType = type {
            viewContainer?.backgroundColor = infoType.backgroundColor
            lblTitle.attributedText = infoType.title
            lblInfo.attributedText = infoType.info
            switch infoType {
                case .staus(let info):
                    imgVwStatus.image = info.image
                    constraintStatusHeight.constant = 25
                default:
                    imgVwStatus.image = nil
                    constraintStatusHeight.constant = 0
            }
        }
    }
}
