    //
//  NowPlayingViewController.swift
//  Flix_demo
//
//  Created by Eduardo Carrillo on 12/27/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    
    
    let movieCellIdentifier = "MovieCell"
    
    var movies: [Movie] = []
    
    //Implicitly unwrapped optional
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
          let cell = tableview.dequeueReusableCell(withIdentifier: movieCellIdentifier, for: indexPath) as! MovieCell
        
        print("cell height: \(cell.contentView.frame.height)")
        
        cell.frame = CGRect(x: 0, y: 0, width: 50, height: 200)
        
        let movie = movies[indexPath.row]
        cell.movie = movie
        return cell
    }
    

    
    static let apiKey = "e9f5b138a689fa649425663ddc8d0d4c"
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: UIControlEvents.valueChanged)
        
        tableview.dataSource = self
        //0 means at the top
        tableview.insertSubview(refreshControl, at: 0)
        refreshData()
        
    }
    
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        activityIndicator.startAnimating()
        refreshData()
    }
    
    func refreshData(){
        MovieAPIManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let error = error {
                print("Could not refresh data.")
            }else if let movies = movies {
                self.movies = movies
                self.tableview.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! MovieCell
        guard let indexPath =  tableview.indexPath(for: cell) else {
            print("No indexPath!")
            return
        }
        
        let movie = self.movies[indexPath.row]
        
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.movie = movie
    }

  

}
