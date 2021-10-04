//
//  Character.swift
//  RickyMorty
//

import Foundation
import Alamofire

/**
 CharacterOrigin struct for decoding character json origin response.
 ### Properties
 - **name**: Name of the character origin location.
 - **url**: URL endpoint.
 */
public struct CharacterOrigin: Codable {
    public let name: String
    public let url: String
}


/**
 CharacterLocation struct for decoding character location json response.
 ### Properties
 - **name**: Name of the character last location.
 - **url**: URL endpoint.
 */
public struct CharacterLocation: Codable {
    public let name: String
    public let url: String
}


/**
 Character struct for decoding character json response.
 ### Properties
 - **id**:  ID of the character.
 - **name**: Name of the character.
 - **status**: Status of the character.
 - **species**: Species of the character.
 - **type**: Type of the character.
 - **gender**: Gender of the character.
 - **origin**: Origin location of the character.
 - **location**: Last location of the character.
 - **image**: Image of character's.
 - **episodes**: Episodes in which this character appeared.
 - **url**: URL endpoint.
 - **created**: Time at which the character was created in the database.
 */
public struct Character: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let origin: CharacterOrigin
    public let location: CharacterLocation
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String
}

/**
 CharacterAPI struct contains all functions to request character(s) information(s).
 */
class CharacterAPI: NSObject {
    private var dataRequest: DataRequest?
    public typealias Block = ((CharacterVM?, String?)-> ())?

    /// Request characters by PageURL.
    /// - Parameters:
    ///   - url: **String** object to fetch the character details
    ///   - completionBlock: Perform an operation after API response.
    func fetchCharacter(_ detail: CharacterDetailVM, completionBlock: Block = nil) {
        guard let characterID = Int(String(detail.urlEndPoint.lastPathComponent))
        else {
            completionBlock?(nil, "~NO CHARACTER FOUND.")
            return
        }
        let apiClient = APIClient(RickyMortyEndPoint.singleCharacter(characterID))
        dataRequest?.cancel()
        dataRequest = apiClient.call(Character.self, {[weak self](result) in
            guard let _ = self else{return}
            switch result {
                case .success(let character):
                    completionBlock?(CharacterVM(character), nil)
                case .failure(let reason, let statusCode):
                    vPrint("\(reason) : \(String(describing: statusCode))")
                    DispatchQueue.main.async {completionBlock?(nil, reason)}
            }
        })
    }
}
