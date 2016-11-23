//
//  Movie.swift
//  MovieNight
//
//  Created by Mathias Vang Rasmussen on 23/11/2016.
//  Copyright © 2016 ReCapted. All rights reserved.
//

import Foundation

struct Movie: MovieType {
    
    let overview: String?
    let id: Int?
    let title: String?
    let imageURL: URL?
    let type = Type.movie
    var selected = false
    
    init?(json: JSONDict) {
        guard let overview = json["overview"] as? String, let id = json["id"] as? Int, let title = json["title"] as? String, let imageURL = json["poster_path"] as? String else { return nil }
        
        self.overview = overview
        self.id = id
        self.title = title
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/original\(imageURL)") {
            self.imageURL = imageURL
        } else {
            self.imageURL = nil
        }
    }
}
