//
//  CharacterInfoVM.swift
//  RickyMorty
//

import UIKit

//MARK: - Class CharacterInfoVM
class CharacterInfoVM: NSObject {
}

//MARK:- Enum CharacterInfoTypes
enum CharacterInfoTypes {
    case staus(_ info: CharacterStatusType)
    case species(_ info: String)
    case gender(_ info: CharacterGenderType)
    case type(_ info: String)
    case origin(_ info: String)
    case lastLocation(_ info: String)
    
    var backgroundColor: UIColor {
        switch self {
            case .staus, .gender, .origin:
                return .app1E1E1E
            case .species, .type, .lastLocation:
                return .clear
        }
    }

    var title: NSAttributedString {
        switch self {
            case .staus:
                return "~STATUS".localized.setString(.natural, lineBreakMode: .byTruncatingTail, textFont: .montserratMedium(ofSize: 16), foregroundColor: .appFFFFFF)
            case .species:
                return "~SPECIES".localized.setString(.natural, lineBreakMode: .byTruncatingTail, textFont: .montserratMedium(ofSize: 16), foregroundColor: .appFFFFFF)
            case .gender:
                return "~GENDER".localized.setString(.natural, lineBreakMode: .byTruncatingTail, textFont: .montserratMedium(ofSize: 16), foregroundColor: .appFFFFFF)
            case .type:
                return "~TYPE".localized.setString(.natural, lineBreakMode: .byTruncatingTail, textFont: .montserratMedium(ofSize: 16), foregroundColor: .appFFFFFF)
            case .origin:
                return "~ORIGIN".localized.setString(.natural, lineBreakMode: .byTruncatingTail, textFont: .montserratMedium(ofSize: 16), foregroundColor: .appFFFFFF)
            case .lastLocation:
                return "~LAST LOCATION".localized.setString(.natural, lineBreakMode: .byTruncatingTail, textFont: .montserratMedium(ofSize: 16), foregroundColor: .appFFFFFF)
        }
    }

    var info: NSAttributedString {
        switch self {
            case .staus(let info):
                return info.title.setString(.right, lineBreakMode: .byTruncatingTail, textFont: .montserratMedium(ofSize: 12), foregroundColor: .appFFFFFFA80)
            case .species(let info):
                return info.setString(.right, lineBreakMode: .byTruncatingTail, textFont: .montserratMedium(ofSize: 12), foregroundColor: .appFFFFFFA80)
            case .gender(let info):
                return info.title.setString(.right, lineBreakMode: .byTruncatingTail, textFont: .montserratMedium(ofSize: 12), foregroundColor: .appFFFFFFA80)
            case .type(let info):
                return info.setString(.right, lineBreakMode: .byTruncatingTail, textFont: .montserratMedium(ofSize: 12), foregroundColor: .appFFFFFFA80)
            case .origin(let info):
                return info.setString(.right, lineBreakMode: .byTruncatingTail, textFont: .montserratMedium(ofSize: 12), foregroundColor: .appFFFFFFA80)
            case .lastLocation(let info):
                return info.setString(.right, lineBreakMode: .byTruncatingTail, textFont: .montserratMedium(ofSize: 12), foregroundColor: .appFFFFFFA80)
        }
    }
}
