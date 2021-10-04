//
//  String.swift
//  RickyMorty
//

import UIKit

//MARK: String Extension Propertie(s)
extension String {
    
    /// It is used to get localiztion texts.
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// It is used to get URL from string.
    var fileURL: URL {
        return URL(fileURLWithPath: self)
    }
    
    /// It is used to get path extension.
    var pathExtension: String {
        return fileURL.pathExtension
    }
    
    /// It is used to get last path component
    var lastPathComponent: String {
        return fileURL.lastPathComponent
    }

    /// It is used to convert `String` type value to `Int` type value.
    public var toInt: Int? {return Int(self)}
    
}

//MARK: String Extension Method(s)
extension String {
    
    /// It will return random number based on given length
    /// - Parameter length: Represent number of length which you want in random number.
    /// - Returns: Return random number
    public static func random(_ characters: String = "0123", length: Int) -> Int {
        return String((0..<length).map{ _ in characters.randomElement()! }).toInt!
    }
    
    /// It is used to calculate height for given string based on fixed width.
    /// - Parameters:
    ///   - width: `CGFloat` type value.
    ///   - font: `UIFont` type value.
    /// - Returns: It will return calculated height in `CGFloat` type.
    public func heightForFixed(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return boundingBox.height
    }
    
    /// It is used to set string alignment, font, foreground color as per given parameter. It will call internally `NSMutableAttributedString` function.
    /// - Parameters:
    ///   - alignment: `NSTextAlignment` type object to define text alignment. Default value is **.natural**.
    ///   - textFont: `UIFont` type object. Default value is **nil**.
    ///   - foregroundColor: `UIColor` type object. Default value is **nil**.
    /// - Returns: It will return `NSAttributedString`.
    public func setString(_ alignment: NSTextAlignment = .natural, lineBreakMode: NSLineBreakMode = .byTruncatingTail, textFont: UIFont? = nil, foregroundColor: UIColor? = nil) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = lineBreakMode
        
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttributes(paragraphStyle, textFont: textFont, foregroundColor: foregroundColor, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
}

//MARK: - NSMutableAttributedString Extension Method(s)
extension NSMutableAttributedString {
    
    /// It is used to add atttributed keys and values as per given parameters.
    /// - Parameters:
    ///   - paragraphStyle: `NSParagraphStyle` type object. Default value is **nil**.
    ///   - textFont: `UIFont` type object. Default value is **nil**.
    ///   - foregroundColor: `UIColor` type object. Default value is **nil**.
    ///   - range: `NSRange` type object.
    fileprivate func addAttributes(_ paragraphStyle: NSParagraphStyle? = nil,
                                   textFont: UIFont? = nil,
                                   foregroundColor: UIColor? = nil,
                                   range: NSRange) {
        
        if let paragraphStyle = paragraphStyle {
            addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        }
        
        if let textFont = textFont {
            addAttribute(.font, value: textFont, range: range)
        }
        
        if let foregroundColor = foregroundColor {
            addAttribute(.foregroundColor, value: foregroundColor, range: range)
        }
    }
}
