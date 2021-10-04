//
//  LocationVM.swift
//  RickyMorty
//

import Foundation

/**
 LocationVM struct used to display it's value on UIs part.
 ### Properties
 - **id**: The id of the location.
 - **type**: The type of the location.
 - **name**: The name of the location.
 - **dimension**: The dimension of the location.
 - **residents**: List of residents who have been seen in the location.
 */
struct LocationVM {
    var id: Int
    var type: String
    var name: String
    var dimension: String
    var residents: [String]
    var displayResidentsCount: String {
        if residents.isEmpty {
            return "~No residents".localized
        }else if residents.count == 1 {
            return residents.count.description + "~Resident".localized
        }else {
            return residents.count.description + "~Residents".localized
        }
    }
    /// It will initialized object from **Location** model
    /// - Parameter giphy: It will represent **Location** object value.
    init(_ location: Location) {
        id = location.id
        type = location.type
        name = location.name
        dimension = location.dimension
        residents = location.residents
    }
}
