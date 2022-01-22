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

    var movies = [] as [Movie]
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    
    let network = Network()
    
    var thisToken = RequestToken(success: nil, expires_at: nil, request_token: nil)
//    var thisMovie = Movie(name: nil);
    var thisMovie = Movie(vote_average: nil, backdrop_path: nil, overview: nil, release_date: nil, title: nil, poster_path: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
          self.tableView.dataSource = self
        self.searchBar.delegate = self
        let cBtn = searchBar.value(forKey: Constant.cancelButtonID) as! UIButton
        cBtn.setTitle(Constant.goButtonText, for: .normal)
    }
    
  
    
    func downloadSearchResults(){
        let searchTerm = searchBar.text ?? ""
        var endpoint = Constant.movieSearchEndPoint + Constant.theApiKey + Constant.movieSearchQueryString + searchTerm
        endpoint = endpoint.replacingOccurrences(of: " ", with: Constant.spaceSymbol)
        network.dataRequest(with: endpoint, objectType: Response.self) { (result: Result) in
          switch result {
          case .success(let object):
              self.movies = object.results
              DispatchQueue.main.async {
              self.tableView.reloadData()
              }
          case .failure(let error):
              print(error)
          }
      }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellID , for: indexPath) as! MovieTableViewCell
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
        performSegue(withIdentifier: Constant.detailSegueID, sender: self)
    }
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        downloadSearchResults()
    }


    
    
}
