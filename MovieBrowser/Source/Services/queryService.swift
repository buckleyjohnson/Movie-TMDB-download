//
//  queryService.swift
//  MovieBrowser
//
//  Created by buckley johnson on 1/21/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation


//Result enum to show success or failure
  
    
    struct Example: Decodable {
        let userId: Int
        let id: Int
        let title: String
        let completed: Bool
    }

    struct APIRequest {
        var resourceURL: URL
        let urlString = "https://jsonplaceholder.typicode.com/todos/1"
       
        init() {
            resourceURL = URL(string: urlString)!
        }
        
        //create method to get decode the json
        func requestAPIInfo(completion: @escaping(Result<Example>) -> Void) {
            let dataTask = URLSession.shared.dataTask(with: resourceURL) { (data, response, error) in
                
                guard error == nil else {
                    print (error!.localizedDescription)
                    print ("stuck in data task")
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let jsonData = try decoder.decode(Example.self, from: data!)
                    completion(.success(jsonData))
                }
                catch {
                    print ("an error in catch")
                    print (error)
                }
            }
            dataTask.resume()
        }
    }



