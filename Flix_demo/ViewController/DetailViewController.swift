//
//  DetailViewController.swift
//  Flix_demo
//
//  Created by Eduardo Carrillo on 12/28/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    enum MovieKeys {
        static let title = "title"
        static let releaseDate = "release_date"
        static let overview = "overview"
        static let backdropPath = "backdrop_path"
        static let posterPath = "poster_path"
    }

    
    @IBOutlet weak var backdropImageView: UIImageView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    
    
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = self.movie {
            self.titleLabel.text = movie[MovieKeys.title] as? String
            self.releaseDateLabel.text = movie[MovieKeys.releaseDate] as? String
            self.overviewLabel.text = movie[MovieKeys.overview] as? String
            let backdropPathString = movie[MovieKeys.backdropPath] as! String
            let posterPathString = movie[MovieKeys.posterPath] as! String
            
            let baseUrlString  = "https://image.tmdb.org/t/p/w500"
            
            
            let backdropURL = URL(string: "\(baseUrlString)\(backdropPathString)")
            self.backdropImageView.af_setImage(withURL: backdropURL!)
            
            let posterPathURL = URL(string: "\(baseUrlString)\(posterPathString)")
            self.posterImageView.af_setImage(withURL: posterPathURL!)
            
            
            
            
        }
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
