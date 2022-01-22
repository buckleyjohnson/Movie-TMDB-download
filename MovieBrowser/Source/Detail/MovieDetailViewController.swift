//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    let network = Network()
    var releaseDate = "";
    var movieTitle = String()
    var poster = "";
    var overview = "";
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var overviewTextView: UITextView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(movieTitle)
        movieTitleLabel.text = movieTitle;
        releaseDateLabel.text = releaseDate;
        overviewTextView.text = overview;
        posterImage.image = UIImage(named: "placeholder")
        
        let urlString = "https://image.tmdb.org/t/p/w500/" + poster 
        
        print(urlString)
        let url = URL(string: urlString)!
           downloadImage(from: url)
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        network.getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.posterImage.image = UIImage(data: data)
            }
        }
    }
    
}
