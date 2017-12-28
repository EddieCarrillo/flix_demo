//
//  SuperHeroViewController.swift
//  Flix_demo
//
//  Created by Eduardo Carrillo on 12/28/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit

class SuperHeroViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [[String: Any]] = []
    static let apiKey = "e9f5b138a689fa649425663ddc8d0d4c"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        refreshData()
        
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let cellsPerLine = 4
        let interItemSpacingTotal = layout.minimumInteritemSpacing * CGFloat((cellsPerLine - 1))

        let width = (collectionView.frame.size.width - interItemSpacingTotal) / CGFloat(cellsPerLine)
        
        layout.itemSize = CGSize(width: width, height: (3/2)*width)
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func refreshData(){
        guard let url =  URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(NowPlayingViewController.apiKey)") else {
            print("Could not load the URL")
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            //   self.refreshControl.endRefreshing()
            //self.activityIndicator.stopAnimating()
            
            //This will run when the network request returns
            if let error = error{
                print("[ERROR] \(error.localizedDescription)")
            }else if let data = data {
                
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.collectionView.reloadData()
                
            }
            
        }
        
        task.resume()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return movies.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        
        let movie = movies[indexPath.row] as! [String: Any]
        if let posterPathString = movie["poster_path"] as? String {
            let baseUrlString  = "https://image.tmdb.org/t/p/w500"
            let posterPathURL = URL(string: "\(baseUrlString)\(posterPathString)")
            cell.posterImageView.af_setImage(withURL: posterPathURL!)
        }
        
        return cell
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
