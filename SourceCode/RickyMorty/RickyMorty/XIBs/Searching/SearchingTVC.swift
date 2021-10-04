//
//  SearchingTVC.swift
//  RickyMorty
//

import UIKit

//MARK: - Class SearchingTVC
class SearchingTVC: ParentTVC {
    @IBOutlet weak var viewActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lblSearchTerms: UILabel!
    
    /// It will accept **String** value.
    var searchTerms: String? {
        didSet {
            prepareUIs()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// It will prepare UIs.
    private func prepareUIs() {
        viewActivityIndicator.startAnimating()
        lblSearchTerms.text = "~Searching for".localized + " \"" + (searchTerms  ?? "") + "\""
    }
}
