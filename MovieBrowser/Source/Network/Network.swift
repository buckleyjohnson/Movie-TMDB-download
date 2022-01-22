//
//  Network.swift
//  MovieBrowser
//
//  Created by buckley johnson on 1/21/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

//["success": 1, "expires_at": 2022-01-22 02:24:47 UTC, "request_token": 767868eae29ce0f3b16cfce94f98565334a74b30]

enum APPError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
}

enum Result<T> {
    case success(T)
    case failure(APPError)
}

struct ToDo: Decodable {
    let id: Int
    let userId: Int
    let title: String
    let completed: Bool
}
struct RequestToken: Decodable {
    let success: Bool?
    let expires_at: String?
    let request_token: String?
    
}

struct Response: Codable {
    let results: [Movie]
}

class Network {
    
        func dataRequest<T: Decodable>(with url: String, objectType: T.Type, completion: @escaping (Result<T>) -> Void) {

            
            let dataURL = URL(string: url)!
            let session = URLSession.shared
            let request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
            let task = session.dataTask(with: request, completionHandler: { data, response, error in
                guard error == nil else {
                    completion(Result.failure(APPError.networkError(error!)))
                    return
                }

                guard let data = data else {
                    completion(Result.failure(APPError.dataNotFound))
                    return
                }

                do {
                    let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                    completion(Result.success(decodedObject))
                } catch let error {
                    completion(Result.failure(APPError.jsonParsingError(error as! DecodingError)))
                }
            })

            task.resume()
        }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    
}

