//
//  PosterCell.swift
//  Flix_demo
//
//  Created by Eduardo Carrillo on 12/28/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit

class PosterCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: Movie!{
        didSet{
            self.posterImageView.af_setImage(withURL: movie.posterURL!)
        }
    }
}
