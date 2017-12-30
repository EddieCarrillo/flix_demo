//
//  File.swift
//  Flix_demo
//
//  Created by Eduardo Carrillo on 12/29/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import Foundation



class MovieAPIManager{
    
    
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    static let apiKey = "e9f5b138a689fa649425663ddc8d0d4c"
    
    
    var session: URLSession
    
    
    
    init(){
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    
    func nowPlayingMovies(completion: @escaping ([Movie]?, Error?) -> ()){
        guard  let url = URL(string: MovieAPIManager.baseURL +  "now_playing?api_key=\(MovieAPIManager.apiKey)") else {
            completion(nil, NSError(domain: "Bad URL", code: 404, userInfo: nil))
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print("[ERROR] \(error)")
                completion(nil, error)
            }else if let data = data {
                let dataDictionary =  try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let moviesDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                let movies = Movie.getMovies(from: moviesDictionaries)
                completion(movies, nil)
            }
        }
        
        task.resume()
        
        
    }
    
}
