//
//  RestAPIClient.swift
//  UserApp
//
//  Created by Girish Parate on 22/09/22.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case BadURL
    case NoData
    case DecodingError
    case NetworkErrorAPIError(String)
}

class RestAPIClient {
    static func request<T: Codable>(type: T.Type,
                                    endPoint: String,
                                    method: HTTPMethod = .get,
                                    parameters: Parameters? = nil,
                                    completion: @escaping(Result<T,NetworkError>) -> Void) {
        
        AF.request(endPoint,method: method, parameters: parameters,encoding: URLEncoding.default).response { response in
            DispatchQueue.main.async {
                let statusCode = response.response?.statusCode
                if(statusCode == 200 || statusCode == 201) {
                    let result = response.result
                    switch result {
                    case .success(let data):
                        guard let data = data else {
                            completion(.failure(.NoData))
                            return
                        }
                        guard let obj = try? JSONDecoder().decode(T.self, from: data) else {
                            completion(.failure(.DecodingError))
                            return
                        }
                        completion(.success(obj))
                    case .failure(let error):
                        completion(.failure(.NetworkErrorAPIError(error.localizedDescription)))
                    }
                } else if(statusCode == 400) {
                    guard let jsonData = response.data else{
                        return
                    }
                    do {
                        let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
                        let error = json!["error"]
                        completion(.failure(.NetworkErrorAPIError(error as! String)))
                    } catch {
                        print("Error deserializing JSON: \(error)")
                    }
                } else if(statusCode != 500){
                    completion(.failure(.NetworkErrorAPIError("Api Erro 500")))
                }
            }
        }
    }
}
