//
//  APIClient.swift
//  RickyMorty
//

import Foundation
import Alamofire

//MARK: - Enum Result<T>
enum Result<T>{
    case success(T)
    case failure(reason: String, statusCode: Int?)
}

//MARK: - Class APIClient
class APIClient {
    private let endPointProtocol: EndPointProtocol
    private var network: APIClient?
    private static var toastBar: ToastBarView?
    private static var networkReachabilityManager = NetworkReachabilityManager.default!
    static var isInternetAvailable: Bool {networkReachabilityManager.isReachable}
    
    init(_ endPointProtocol: EndPointProtocol) {
        self.endPointProtocol = endPointProtocol
    }
    
    @discardableResult func callRequest(_ afDataResponse: @escaping ((AFDataResponse<Data>) -> Void)) -> DataRequest? {
        return AF.request(
            endPointProtocol.URL,
            method: endPointProtocol.httpMethod,
            parameters: endPointProtocol.parameters,
            encoding: endPointProtocol.parameterEncoding,
            headers: endPointProtocol.headers)
            .responseData(completionHandler: afDataResponse)
    }
    
    @discardableResult func call<T: Decodable>(_ decoderType: T.Type,_ result: @escaping (_ encodedData: Result<T>)->()) -> DataRequest?   {
        return callRequest { response in
            guard let _ = response.response?.statusCode else {return}
            let apiResponse = APIResponse(response: response)
            switch apiResponse {
                case .success:
                    guard let data = response.data else {
                        result(.failure(reason: "Failed to parse data".localized, statusCode: nil))
                        return
                    }
                    do {
                        let codableData = try JSONDecoder().decode(decoderType.self, from: data)
                        result(.success(codableData))
                    } catch let error as NSError {
                        vPrint(error)
                        result(.failure(reason: "Failed to parse data".localized, statusCode: nil))
                    }
                case .failed(let reason, let statusCode):
                    result(.failure(reason: reason, statusCode: statusCode))
            }
        }
    }
    
    @discardableResult func call(_ result: @escaping (_ encodedData: Result<Int>)->()) -> DataRequest? {
        return AF.request(
            endPointProtocol.URL,
            method: endPointProtocol.httpMethod,
            parameters: endPointProtocol.parameters,
            encoding: endPointProtocol.parameterEncoding,
            headers: endPointProtocol.headers)
            .responseData { response in
                guard let statusCode = response.response?.statusCode else {return}
                let apiResponse = APIResponse(response: response)
                switch apiResponse {
                    case .success:
                        guard let _ = response.data else { result(.success(statusCode)); return }
                        result(.success(statusCode))
                    case .failed(let reason, let statusCode):
                        result(.failure(reason: reason, statusCode: statusCode))
                }
            }
    }
}

//MARK: Internet Availability
extension APIClient{
    
    static func addInterNetListner() {
        networkReachabilityManager.startListening {(status) in
            if case .reachable(_) = status {
                vPrint("INTERNET AVAILABLE.")
                _defaultCenter.post(name: nfInternetAvailable, object: nil, userInfo: nil)
                self.toastBar?.animateOut(0.3, delay: 0.0, completion: {
                    self.toastBar?.removeFromSuperview()
                })
            }else{
                vPrint("INTERNET NOT AVAILABLE.")
                _defaultCenter.post(name: nfInternetNotAvailable, object: nil, userInfo: nil)
                self.toastBar = ToastBar.shared.show("~Your internet connection seems to be down.".localized, type: .error, autoHide: false)
            }
        }
    }
}
