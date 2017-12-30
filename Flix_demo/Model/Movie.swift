//
//  Movie.swift
//  Flix_demo
//
//  Created by Eduardo Carrillo on 12/29/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import Foundation


class Movie {
    
    
    enum MovieKeys {
        static let title = "title"
        static let releaseDate = "release_date"
        static let overview = "overview"
        static let backdropPath = "backdrop_path"
        static let posterPath = "poster_path"
    }
    
    var title: String
    var releaseDate: Date?
    var overview: String
    var backdropURL: URL?
    var posterURL: URL?
    
    
    init(dictionary: [String: Any]){
        
        title = dictionary[MovieKeys.title] as? String  ?? "No title"
        
        releaseDate = dictionary[MovieKeys.releaseDate] as? Date
        
        overview = dictionary[MovieKeys.overview] as? String ?? "This the overview"
        
        let baseUrlString = "https://image.tmdb.org/t/p/w500"
        
        if let backdropPath = dictionary[MovieKeys.backdropPath] {
            backdropURL = URL(string: "\(baseUrlString)\(backdropPath)" )
        }
        if let posterPath = dictionary[MovieKeys.posterPath] {
            posterURL = URL(string: "\(baseUrlString)\(posterPath)" )
        }
        
        
        
        //Set the rest of the description
        
        
        
    }
    
    class func getMovies(from dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        
        for movieDictionary in dictionaries {
            movies.append(Movie(dictionary: movieDictionary))
        }
        
        
        return movies
    }
    
    
}
