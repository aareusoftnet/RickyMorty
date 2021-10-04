//
//  Episode.swift
//  RickyMorty
//

import Foundation
import Alamofire

/**
 EpisodeInfo struct for decoding info json response.
 ### Properties
 - **info**: Information about episode count and pagination.
 - **results**: List of episode information.
 
 ### SeeAlso
 - **info**: Info struct in Info.swift.
 */
struct EpisodeInfo: Codable {
    let info: Info
    let results: [Episode]
}

/**
 Episode struct for decoding episode api response.
 ### Properties
 - **id**: ID of the episode.
 - **name**: Name of the episode.
 - **airDate**: AirDate of the episode.
 - **episode**: Code of the episode.
 - **characters**: List of characters who have been seen in the episode.
 - **url**: URL endpoint.
 - **created**: Time at which the episode was created in the database.
 */
struct Episode: Codable, Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, url, created
        case airDate = "air_date"
    }
}

/**
 EpisodeAPI struct contains all functions to request episode(s) information(s).
 */
class EpisodeAPI: NSObject {
    private var dataRequest: DataRequest?
    public typealias Block = (([EpisodeVM]?, String?)-> ())?

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

    /// It will handle EpisodeInfo response.
    /// - Parameters:
    ///   - episodeInfo: It will represent **EpisodeInfo** object.
    ///   - pagination: **Pagination** object to handle pagination.
    ///   - completionBlock: Perform an operation after API response.
    private func handleEpisodesResponse(_ episodeInfo: EpisodeInfo, pagination: Pagination, completionBlock: Block = nil) {
        pagination.setISAllLoaded(episodeInfo.info.next == nil)
        var arrOfEpisodes: [EpisodeVM] = []
        episodeInfo.results.forEach { (objEpisode) in arrOfEpisodes.append(EpisodeVM(objEpisode))}
        DispatchQueue.main.async {completionBlock?(arrOfEpisodes,nil)}
    }

    /// Request episodes by PageURL.
    /// - Parameters:
    ///   - pagination: **Pagination** object to handle pagination.
    ///   - completionBlock: Perform an operation after API response.
    private func getEpisodesUsing(_ pagination: Pagination, completionBlock: Block = nil) {
        let updatedRequestParameter = getUpdateRequest(pagination, parameters: nil)
        let apiClient = APIClient(RickyMortyEndPoint.episode(updatedRequestParameter))
        dataRequest?.cancel()
        dataRequest = apiClient.call(EpisodeInfo.self, {[weak self](result) in
            guard let self = self else{return}
            switch result {
                case .success(let episodeInfo):
                    self.handleEpisodesResponse(episodeInfo, pagination: pagination, completionBlock: completionBlock)
                case .failure(let reason, let statusCode):
                    vPrint("\(reason) : \(String(describing: statusCode))")
                    DispatchQueue.main.async {completionBlock?(nil, reason)}
            }
        })
    }

    /// Request episodes by PageURL.
    /// - Parameters:
    ///   - pagination: **Pagination** object to handle pagination.
    ///   - completionBlock: Perform an operation after API response.
    private func searchEpisodesUsing(_ name: String, pagination: Pagination, completionBlock: Block = nil) {
        let updatedRequestParameter = getUpdateRequest(pagination, parameters: ["name" : name])
        let apiClient = APIClient(RickyMortyEndPoint.episode(updatedRequestParameter))
        dataRequest?.cancel()
        dataRequest = apiClient.call(EpisodeInfo.self, {[weak self](result) in
            guard let self = self else{return}
            switch result {
                case .success(let episodeInfo):
                    self.handleEpisodesResponse(episodeInfo, pagination: pagination, completionBlock: completionBlock)
                case .failure(let reason, let statusCode):
                    vPrint("\(reason) : \(String(describing: statusCode))")
                    DispatchQueue.main.async {completionBlock?(nil, reason)}
            }
        })
    }
    
    /// It will fetch episodes based on searched query or default episodes.
    /// - Parameters:
    ///   - name: Episode name to search episodes with name.
    ///   - pagination: **Pagination** object to handle pagination.
    ///   - completionBlock: Perform an operation after API response.
    func fetchEpisodes(_ name: String? = nil, pagination: Pagination, completionBlock: Block = nil) {
        if let name = name,
           name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            searchEpisodesUsing(name, pagination: pagination, completionBlock: completionBlock)
        }else{
            getEpisodesUsing(pagination, completionBlock: completionBlock)
        }
    }
}
