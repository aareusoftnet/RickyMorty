//
//  CharacterFilterOptionListTVC.swift
//  RickyMorty
//

import UIKit

//MARK: - Class CharacterFilterOptionListTVC
class CharacterFilterOptionListTVC: ParentTVC {
    @IBOutlet weak var viewStackContainer: UIStackView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgVwCheckBox: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

//MARK: UIRelated
extension CharacterFilterOptionListTVC {
    
    /// It will prepare LocationList data.
    func prepareUIs(_ option: Any?, selectedOption: Any?) {
        var isSelected: Bool = false
        if let statusType = option as? CharacterStatusType {
            lblName.attributedText = statusType.title.setString(.natural, lineBreakMode: .byTruncatingTail, textFont: .montserratBold(), foregroundColor: .appFFFFFF)
            guard let selectedStatusType = selectedOption as? CharacterStatusType else {imgVwCheckBox.image = .imgCheckBox; return;}
            isSelected = statusType == selectedStatusType
        }else if let genderType = option as? CharacterGenderType {
            lblName.attributedText = genderType.title.setString(.natural, lineBreakMode: .byTruncatingTail, textFont: .montserratBold(), foregroundColor: .appFFFFFF)
            guard let selectedGenderType = selectedOption as? CharacterGenderType else {imgVwCheckBox.image = .imgCheckBox; return;}
            isSelected = genderType == selectedGenderType
        }
        imgVwCheckBox.image = isSelected ? .imgCheckedBox : .imgCheckBox
    }
}
