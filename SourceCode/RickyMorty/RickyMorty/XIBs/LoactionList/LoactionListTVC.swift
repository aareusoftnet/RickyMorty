//
//  LoactionListTVC.swift
//  RickyMorty
//

import UIKit

//MARK: - Class LoactionListTVC
class LoactionListTVC: ParentTVC {
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewStackDimensionCharacter: UIStackView!
    @IBOutlet weak var lblDimension: UILabel!
    @IBOutlet weak var lblResidents: UILabel!
    var location: LocationVM? {
        didSet {
            prepareUIs()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUIs()
    }
}

//MARK: UIRelated
extension LoactionListTVC {
    
    /// It will prepare LocationList data.
    private func prepareUIs() {
        if let location = location {
            lblType.text = location.type
            lblName.text = location.name
            lblDimension.text = location.dimension
            lblResidents.text = location.displayResidentsCount
        }
    }
}
