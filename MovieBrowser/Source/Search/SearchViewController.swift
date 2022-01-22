//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//


import UIKit


class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var release_date: UILabel!
    @IBOutlet weak var vote_average: UILabel!
}


class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    var data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
        "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
        "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
        "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
        "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]

    var movies = [] as [Movie]
    var filteredData: [String]!
//    var allRes = [Response]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let apiRequest = APIRequest()
    let networkService = NetworkService()
    let networker = Networker()
    
    let network = Network()
    
    var thisToken = RequestToken(success: nil, expires_at: nil, request_token: nil)
//    var thisMovie = Movie(name: nil);
    var thisMovie = Movie(vote_average: nil, backdrop_path: nil, overview: nil, release_date: nil, title: nil, poster_path: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
          self.tableView.dataSource = self
        filteredData = data
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.setClientID), name: NSNotification.Name(rawValue: "SetClientID"), object: nil)
       downloadSearchResults()
    }
    
    func downloadSearchResults(){
    
//        var endpoint = "https://api.themoviedb.org/3/search/company?api_key=eeeda56a8124f339d5df7df69b811730"
//        endpoint = endpoint + "&query=star" + searchBar.text! + "&page=1"
      
        var endpoint = "https://api.themoviedb.org/3/search/movie?api_key=eeeda56a8124f339d5df7df69b811730&language=en-US&page=1&include_adult=false&query=star"
        
       
       // endpoint = "https://api.themoviedb.org/3/movie/550?api_key=eeeda56a8124f339d5df7df69b811730"
        network.dataRequest(with: endpoint, objectType: Response.self) { (result: Result) in
          switch result {
          case .success(let object):
              self.movies = object.results
              DispatchQueue.main.async {
              self.tableView.reloadData()
              }
              NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetClientID"), object: nil)
           
              
          case .failure(let error):
              print(error)
          }
      }
    }
    
    @objc func setClientID(_ notification:NSNotification){
    
      }
    
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
//        cell.textLabel?.text = self.movies[indexPath.row].title
//
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell
    
        cell.title.text =  self.movies[indexPath.row].title
        
        cell.release_date.text =  self.movies[indexPath.row].release_date!.monthAsString()
        cell.vote_average.text = self.movies[indexPath.row].vote_average?.toString()
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.movies.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow{
                vc.movieTitle = self.movies[indexPath.row].title!
                vc.releaseDate = self.movies[indexPath.row].release_date!
                vc.overview = self.movies[indexPath.row].overview!
                vc.poster = self.movies[indexPath.row].poster_path!
             }
            
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Detail", sender: self)
    }
    
    

    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        downloadSearchResults()
        
        
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
//        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
//            // If dataItem matches the searchText, return true to include it
//            return dataString.range(of: searchText, options: .caseInsensitive) != nil
//        })

//        tableView.reloadData()
    }
}
