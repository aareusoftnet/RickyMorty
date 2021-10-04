//
//  NoRecordFoundTVC.swift
//  RickyMorty
//

import UIKit

//MARK: - Class NoRecordFoundTVC
class NoRecordFoundTVC: ParentTVC {
    @IBOutlet weak var lblNoContent: UILabel!
    var content: String? {
        didSet {
            lblNoContent.text = content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
