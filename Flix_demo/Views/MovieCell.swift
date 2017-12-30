 //
//  MovieCell.swift
//  Flix_demo
//
//  Created by Eduardo Carrillo on 12/27/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCell: UITableViewCell {

    
    
    @IBOutlet weak var posterImageview: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: Movie!{
        didSet{
            self.posterImageview.af_setImage(withURL: movie.posterURL!)
            self.titleLabel.text = movie.title
            self.overviewLabel.text = movie.overview
        }
        
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
