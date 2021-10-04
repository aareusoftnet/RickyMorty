//
//  RickyMortyEndPoint.swift
//  RickyMorty
//

import Alamofire

//MARK: - Enum RickyMortyEndPoint
enum RickyMortyEndPoint {
    case episode(_ parameters: [String : Any]?)
    case location(_ parameters: [String : Any]?)
    case singleCharacter(_ id: Int)
}

//MARK: GiphyEndPoint Extension(s)
extension RickyMortyEndPoint: EndPointProtocol {
    
    var pathSuffix: String {
        switch self {
            case .episode:
                return "episode"
            case .location:
                return "location"
            case .singleCharacter(let characterID):
                return "character/\(characterID)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
            case .episode, .location, .singleCharacter:
                return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
            case .episode(let parameters):
                return parameters
            case .location(let parameters):
                return parameters
            case .singleCharacter:
                return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
            case .episode, .location, .singleCharacter:
                return URLEncoding.default
        }
    }
}
