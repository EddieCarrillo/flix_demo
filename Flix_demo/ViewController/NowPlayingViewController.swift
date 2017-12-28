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
    
    var movies: [[String: Any]] = []
    
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
        
        let movie = movies[indexPath.row] as! [String: Any]
        
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let posterPathString = movie["poster_path"] as! String
        
        let urlString =  "https://image.tmdb.org/t/p/w500\(posterPathString)"
        
        let posterUrl = URL(string: urlString)!
        
        cell.posterImageview.af_setImage(withURL: posterUrl)
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        //cell.posterImageview.U
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
        guard let url =  URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(NowPlayingViewController.apiKey)") else {
            print("Could not load the URL")
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            self.refreshControl.endRefreshing()
            self.activityIndicator.stopAnimating()
            
            //This will run when the network request returns
            if let error = error{
                print("[ERROR] \(error.localizedDescription)")
            }else if let data = data {
                
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.tableview.reloadData()
                
            }
            
        }
        
        task.resume()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! MovieCell
        guard let indexPath =  tableview.indexPath(for: cell) else {
            print("No indexPath!")
            return
        }
        
        
        
        let movie = self.movies[indexPath.row] as! [String: Any]
        
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.movie = movie
    }

  

}
