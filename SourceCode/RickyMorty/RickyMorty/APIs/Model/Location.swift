//
//  Location.swift
//  RickyMorty
//

import Foundation
import Alamofire

/**
 LocationInfo struct for decoding info json response.
 ### Properties
 - **info**: Information about location count and pagination.
 - **results**: List of location information.
 
 ### SeeAlso
 - **info**: Info struct in Info.swift.
 */
struct LocationInfo: Codable {
    let info: Info
    let results: [Location]
}

/**
 Location struct for decoding location json response.
 ### Properties
 - **id**: ID of the location.
 - **name**: Name of the location.
 - **type**: Type of the location.
 - **dimension**: Dimension in which the location is located.
 - **residents**: List of location who have been last seen in the location.
 - **url**: URL endpoint.
 - **created**: Time at which the location was created in the database.
 */
public struct Location: Codable, Identifiable  {
    public let id: Int
    public let name: String
    public let type: String
    public let dimension: String
    public let residents: [String]
    public let url: String
    public let created: String
}

/**
 LocationAPI struct contains all functions to request location(s) information(s).
 */
class LocationAPI: NSObject {
    private var dataRequest: DataRequest?
    public typealias Block = (([LocationVM]?, String?)-> ())?

    /// It will update existing request parameters.
    /// - Parameters:
    ///   - pagination: **Pagination** object to handle pagination.
    ///   - parameters: **Dictionary<String,Any>**  object to pass the parameters.
    /// - Returns: It will return update requeset body parameters.
    private func getUpdateRequest(_ pagination: Pagination, parameters: Dictionary<String,Any>?) -> Dictionary<String,Any> {
        var requestParameters: Dictionary<String, Any> = pagination.requestParameters
        guard let parameters = parameters else {return requestParameters}
        requestParameters.merge(parameters)
        return requestParameters
    }

    /// It will handle LocationInfo response.
    /// - Parameters:
    ///   - locationInfo: It will represent **LocationInfo** object.
    ///   - pagination: **Pagination** object to handle pagination.
    ///   - completionBlock: Perform an operation after API response.
    private func handleLocationsResponse(_ locationInfo: LocationInfo, pagination: Pagination, completionBlock: Block = nil) {
        pagination.setISAllLoaded(locationInfo.info.next == nil)
        var arrOfLocations: [LocationVM] = []
        locationInfo.results.forEach { (location) in arrOfLocations.append(LocationVM(location))}
        DispatchQueue.main.async {completionBlock?(arrOfLocations,nil)}
    }

    /// Request locations by PageURL.
    /// - Parameters:
    ///   - pagination: **Pagination** object to handle pagination.
    ///   - completionBlock: Perform an operation after API response.
    private func getLocationsUsing(_ pagination: Pagination, completionBlock: Block = nil) {
        let updatedRequestParameter = getUpdateRequest(pagination, parameters: nil)
        let apiClient = APIClient(RickyMortyEndPoint.location(updatedRequestParameter))
        dataRequest?.cancel()
        dataRequest = apiClient.call(LocationInfo.self, {[weak self](result) in
            guard let self = self else{return}
            switch result {
                case .success(let locationInfo):
                    self.handleLocationsResponse(locationInfo, pagination: pagination, completionBlock: completionBlock)
                case .failure(let reason, let statusCode):
                    vPrint("\(reason) : \(String(describing: statusCode))")
                    DispatchQueue.main.async {completionBlock?(nil, reason)}
            }
        })
    }

    /// Request locations by PageURL.
    /// - Parameters:
    ///   - pagination: **Pagination** object to handle pagination.
    ///   - completionBlock: Perform an operation after API response.
    private func searchLocationsUsing(_ name: String, pagination: Pagination, completionBlock: Block = nil) {
        let updatedRequestParameter = getUpdateRequest(pagination, parameters: ["name" : name])
        let apiClient = APIClient(RickyMortyEndPoint.location(updatedRequestParameter))
        dataRequest?.cancel()
        dataRequest = apiClient.call(LocationInfo.self, {[weak self](result) in
            guard let self = self else{return}
            switch result {
                case .success(let locationInfo):
                    self.handleLocationsResponse(locationInfo, pagination: pagination, completionBlock: completionBlock)
                case .failure(let reason, let statusCode):
                    vPrint("\(reason) : \(String(describing: statusCode))")
                    DispatchQueue.main.async {completionBlock?(nil, reason)}
            }
        })
    }
    
    /// It will fetch locations based on searched query or default locations.
    /// - Parameters:
    ///   - name: Location name to search locations with name.
    ///   - pagination: **Pagination** object to handle pagination.
    ///   - completionBlock: Perform an operation after API response.
    func fetchLocations(_ name: String? = nil, pagination: Pagination, completionBlock: Block = nil) {
        if let name = name,
           name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            searchLocationsUsing(name, pagination: pagination, completionBlock: completionBlock)
        }else{
            getLocationsUsing(pagination, completionBlock: completionBlock)
        }
    }
}
