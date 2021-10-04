//
//  UIFont.swift
//  RickyMorty
//

import UIKit

//MARK: - UIFont Extension(s)
extension UIFont {
    
    //Font Family Name = [Montserrat]
    //Font Names = [["Montserrat-Regular", "Montserrat-Medium", "Montserrat-SemiBold", "Montserrat-Bold"]]

    public static func montserratRegular(ofSize: CGFloat = 14) -> UIFont {
        return UIFont(name: "Montserrat-Regular", size: ofSize)!
    }
    
    public static func montserratMedium(ofSize: CGFloat = 14) -> UIFont {
        return UIFont(name: "Montserrat-Medium", size: ofSize)!
    }
    
    public static func montserratSemiBold(ofSize: CGFloat = 14) -> UIFont {
        return UIFont(name: "Montserrat-SemiBold", size: ofSize)!
    }
    
    public static func montserratBold(ofSize: CGFloat = 14) -> UIFont {
        return UIFont(name: "Montserrat-Bold", size: ofSize)!
    }
}
