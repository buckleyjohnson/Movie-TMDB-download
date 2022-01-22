//
//  Networker.swift
//  MovieBrowser
//
//  Created by buckley johnson on 1/21/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation


class Networker{
    
func loadData() {
    
  
    
        guard let url = URL(string: "https://api.themoviedb.org/3/authentication/token/new?api_key=eeeda56a8124f339d5df7df69b811730") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, res, error in
            if let data = data {
                print("decoding...")
                let str = String(data: data, encoding: .utf8)
                print(str!)

                if let decodedResponse = try? JSONDecoder().decode(TokenResult.self, from: data) {
                    print("decoded!")
                    // cannot get this to print
                    print(decodedResponse.request_token)

                    // looks good, let's get out of here
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
        
    }
}
