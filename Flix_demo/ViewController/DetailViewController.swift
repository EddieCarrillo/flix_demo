//
//  DetailViewController.swift
//  Flix_demo
//
//  Created by Eduardo Carrillo on 12/28/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    

    
    @IBOutlet weak var backdropImageView: UIImageView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = self.movie {
            self.titleLabel.text = movie.title
            self.releaseDateLabel.text = "12/3/2013"
            self.backdropImageView.af_setImage(withURL: movie.backdropURL!)
            self.posterImageView.af_setImage(withURL: movie.posterURL!)
            self.overviewLabel.text = movie.overview
            
            
            
            
            
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
