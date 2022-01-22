//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//


import UIKit

class SearchViewController: UIViewController {
    let apiRequest = APIRequest()
    @IBOutlet weak var label1: UILabel!
    let networkService = NetworkService()
    let networker = Networker()
    
    let network = Network()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        Task {let token = await downloadToken()
        print("3self.thisToken")
        print(token)
        }
    }
    
    func downloadToken()async ->RequestToken{
        var thisToken = RequestToken(success: nil, expires_at: nil, request_token: nil)
        
        network.dataRequest(with: "https://api.themoviedb.org/3/authentication/token/new?api_key=eeeda56a8124f339d5df7df69b811730", objectType: RequestToken.self) { (result: Result) in
          switch result {
          case .success(let object):
              print("token")
              print(object)
              thisToken = object
              
              print("1self.thisToken")
              print(thisToken)
              
          case .failure(let error):
              print(error)
          }
            print("got Token")
            
            print("2self.thisToken")
            print(thisToken)
            
      }
        return thisToken
    }
}
