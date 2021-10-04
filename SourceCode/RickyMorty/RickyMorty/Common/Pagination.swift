//
//  Pagination.swift
//  RickyMorty
//

import Foundation

/**
 Pagination class for handlig pagination in APIs calling.
 ### Properties
 - **isLoading**: To check APIs calling or not.
 - **pageNumber**: To check APIs calling current page number.
 - **isAllLoaded**: To check APIs all data loaded or not.
 */
class Pagination {
    var isLoading: Bool
    var pageNumber: Int
    var isAllLoaded: Bool
    var requestParameters: [String : Any] {
        return ["page" : pageNumber]
    }
    
    /// It is used ot init **Pagination** object.
    /// - Parameters:
    ///   - isLoading: **Bool** value to handle actively calling an APIs or not.
    ///   - pageNumber: **Int** value to handle the paging number.
    ///   - isAllLoaded: **Bool** value to check all the data is loaded from APIs or not.
    init(_ isLoading: Bool = false, pageNumber: Int = 1, isAllLoaded: Bool = false) {
        self.isLoading = isLoading
        self.pageNumber = pageNumber
        self.isAllLoaded = isAllLoaded
    }
    
    /// It is used to increase the page number.
    /// - Parameter pageNumber: **Int** value to increase page number.
    func increase(_ pageNumber: Int) {
        self.pageNumber += pageNumber
    }

    /// It is used to update the **isAllLoaded** property.
    /// - Parameter isAllLoaded: **Bool** value to update it's property.
    func setISAllLoaded(_ isAllLoaded: Bool) {
        self.isAllLoaded = isAllLoaded
    }
}
