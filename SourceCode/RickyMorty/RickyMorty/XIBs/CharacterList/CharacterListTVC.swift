//
//  CharacterListTVC.swift
//  RickyMorty
//

import UIKit

//MARK: - Class CharacterListTVC
class CharacterListTVC: ParentTVC {
    @IBOutlet weak var viewCharacter: UIView!
    @IBOutlet weak var imgVwCharacter: UIImageView!
    @IBOutlet weak var lblSpecies: UILabel!
    @IBOutlet weak var viewStackStatus: UIStackView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imgVwStatus: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    private var loadingCellBGColor: UIColor = .app0D0D0D.withAlphaComponent(0.4)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareDefaultUIs()
        prepareUIs(nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        prepareUIs(nil)
    }
}

//MARK: UIRelated
extension CharacterListTVC {
    
    /// It will prepare CharacterList default UIs.
    private func prepareDefaultUIs() {
        prepareCharacterContainerUIs()
    }
    
    /// It will prepare character container UIs.
    private func prepareCharacterContainerUIs() {
        viewCharacter.backgroundColor = .appFFFFFFA20
        viewCharacter.clipsToBounds = true
        viewCharacter.cornerRadius = 8
        viewCharacter.layer.borderWidth = 1
        viewCharacter.layer.borderColor = UIColor.appFF4C00.cgColor
    }
    
    /// It will prepare CharacterList data.
    func prepareUIs(_ characterDetails: CharacterDetailVM?) {
        if let characterDetails = characterDetails, let details = characterDetails.details {
            viewCharacter.backgroundColor = .clear
            viewCharacter.layer.borderWidth = 1
            imgVwCharacter.setImageWith(details.imageURL, placeholder: nil, completionBlock: nil)
            lblSpecies.text = details.species
            lblSpecies.backgroundColor = .clear
            lblStatus.text = details.status.title
            lblStatus.backgroundColor = .clear
            imgVwStatus.image = details.status.image
            imgVwStatus.backgroundColor = .clear
            lblName.text = details.name
            lblName.backgroundColor = .clear
            lblType.text = details.displayType
            lblType.backgroundColor = .clear
        }else{
            viewCharacter.backgroundColor = loadingCellBGColor
            viewCharacter.layer.borderWidth = 0
            imgVwCharacter.image = nil
            lblSpecies.text = " "
            lblSpecies.backgroundColor = loadingCellBGColor
            lblStatus.text = " "
            lblStatus.backgroundColor = loadingCellBGColor
            imgVwStatus.image = nil
            imgVwStatus.backgroundColor = loadingCellBGColor
            lblName.text = " "
            lblName.backgroundColor = loadingCellBGColor
            lblType.text = " "
            lblType.backgroundColor = loadingCellBGColor
        }
    }
}
