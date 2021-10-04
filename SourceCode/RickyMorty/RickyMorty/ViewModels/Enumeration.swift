//
//  Enumeration.swift
//  RickyMorty
//

import UIKit

//MARK: - Enum CharacterFilterOption
enum CharacterFilterOption {
    case status
    case gender
    
    var title: NSAttributedString {
        switch self {
            case .status:
                return "~Status".localized.setString(.natural, lineBreakMode: .byTruncatingTail, textFont: .montserratBold(), foregroundColor: .appFFFFFF)
            case .gender:
                return "~Gender".localized.setString(.natural, lineBreakMode: .byTruncatingTail, textFont: .montserratBold(), foregroundColor: .appFFFFFF)
        }
    }
    
    var options: [Any] {
        switch self {
            case .status:
                return [CharacterStatusType.alive, CharacterStatusType.dead, CharacterStatusType.unknown]
            case .gender:
                return [CharacterGenderType.female, CharacterGenderType.male, CharacterGenderType.genderLess, CharacterGenderType.unknown]
        }
    }
}

//MARK: - Enum CharacterStatusType
enum CharacterStatusType: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    case none = ""
    
    var title: String {
        switch self {
            case .alive:
                return "~Alive".localized
            case .dead:
                return "~Dead".localized
            case .unknown:
                return "~Unknown".localized
            case .none:
                return ""
        }
    }
    
    var image: UIImage? {
        switch self {
            case .alive:
                return .imgAlive
            case .dead:
                return .imgDead
            case .unknown:
                return .imgUnknown
            case .none:
                return nil
        }
    }
}

//MARK: - Enum CharacterGenderType
enum CharacterGenderType: String {
    case female = "Female"
    case male = "Male"
    case genderLess = "Genderless"
    case unknown = "unknown"
    case none = ""
    
    var title: String {
        switch self {
            case .female:
                return "~Female".localized
            case .male:
                return "~Male".localized
            case .genderLess:
                return "~Genderless".localized
            case .unknown:
                return "~Unknown".localized
            case .none:
                return ""
        }
    }
}
