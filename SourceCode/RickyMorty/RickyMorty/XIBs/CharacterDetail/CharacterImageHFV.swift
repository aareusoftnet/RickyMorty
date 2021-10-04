//
//  CharacterImageHFV.swift
//  RickyMorty
//

import UIKit

//MARK: - Class CharacterImageHFV
class CharacterImageHFV: ParentHFV {
    @IBOutlet weak var imgVwCharacter: UIImageView!
    var imgURL: URL? {
        didSet {
            prepareUIs()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepareUIs() {
        if let imgURL = imgURL {
            imgVwCharacter.setImageWith(imgURL, placeholder: nil, completionBlock: nil)
        }else{
            imgVwCharacter.image = nil
        }
    }
}
