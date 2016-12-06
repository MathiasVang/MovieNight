//
//  Movie.swift
//  MovieNight
//
//  Created by Mathias Vang Rasmussen on 23/11/2016.
//  Copyright © 2016 ReCapted. All rights reserved.
//

import Foundation

struct Movie: MovieType {
    
    let id: Int?
    let title: String?
    let imageURL: URL?
    let type = Type.movie
    var selected = false
    
    init?(resultDecoder result: JSON) {
        guard let
            id = result["id"] as! Int?,
            let title = result["title"] as! String?, let imageURL = result["poster_path"] as? String else { return nil }
        
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/original\(imageURL)") {
            self.imageURL = imageURL
        } else {
            self.imageURL = nil
        }
        
        self.id = id
        self.title = title
    }
}
