//
//  EndPoint.swift
//  RickyMorty
//

import Foundation
import Alamofire

//MARK: - Protocol EndPointProtocol
protocol EndPointProtocol {
    var host: String { get }
    var pathPrefix: String { get }
    var pathSuffix: String { get }
    var URL: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var parameterEncoding: ParameterEncoding { get }
}

//MARK: EndPointProtocol Extension(s)
extension EndPointProtocol {
    
    var host: String {
        switch APIEnvironment.current {
            case .production:
                return "https://rickandmortyapi.com/api"
            case .development:
                return "https://rickandmortyapi.com/api"
            case .mock:
                return "https://rickandmortyapi.com/api"
        }
    }
    
    var pathPrefix: String {
        return "/"
    }
    
    var URL: String {
        return host + pathPrefix + pathSuffix
    }
    
    var headers: HTTPHeaders? {
        return [
            HTTPHeader.contentType("application/json"),
            HTTPHeader.acceptLanguage(Locale.current.languageCode!),
        ]
    }
}
