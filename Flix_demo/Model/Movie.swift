//
//  Movie.swift
//  Flix_demo
//
//  Created by Eduardo Carrillo on 12/29/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import Foundation


class Movie {
    
    var title: String
    var posterURL: URL?
    
    
    init(dictionary: [String: Any]){
        
        title = dictionary["title"] as? String  ?? "No title"
        
        //Set the rest of the description
        
        
        
    }
    
    
}
