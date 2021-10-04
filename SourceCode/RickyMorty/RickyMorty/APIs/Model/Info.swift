//
//  Info.swift
//  RickyMorty
//

import Foundation

/**
 Info struct for decoding api pagination response info.
 ### Properties
 - **count**: Identify the number of records.
 - **pages**: Total page count.
 - **next**: Link to the next page (if it exists)
 - **prev**: Link to the previous page (if it exists).
 */
//MARK: - Struct Info
struct Info: Codable {
    let pages: Int
    let count: Int
    let next: String?
    let prev: String?
}
