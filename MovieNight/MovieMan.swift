//
//  MovieMan.swift
//  MovieNight
//
//  Created by Mathias Vang Rasmussen on 23/11/2016.
//  Copyright © 2016 ReCapted. All rights reserved.
//

import Foundation

struct MovieManager {
    
    fileprivate let networkMan = NetworkManager()
    
    var userChoice1 = [MovieType]()
    var userChoice2 = [MovieType]()
    
    func fetchMoviesWithActor(containing cast: String, completion: @escaping (_ movies: [MovieType]?, _ error: NSError?) -> Void) {
        self.networkMan.requestEndpoint(.Movie, withQueryString: cast) { (result) in
            switch result {
                case .success(let object):
                    JSONParser.parse(json: object as AnyObject, forMovieType: .movie, completion: { (movieType) in
                        completion(movieType, nil)
                    })
                case .failure(let error): completion(nil, error as NSError?)
            }
        }
    }
}
