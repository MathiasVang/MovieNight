//
//  Actor.swift
//  MovieNight
//
//  Created by Mathias Vang Rasmussen on 23/11/2016.
//  Copyright © 2016 ReCapted. All rights reserved.
//

import Foundation

struct Actor: MovieType {
    
    let id: Int?
    let name: String?
    let imageURL: URL?
    var selected = false
    let type = Type.actor
    
    init?(json: JSONDict) {
        guard let name = json["name"] as? String, let id = json["id"] as? Int, let profilePath = json["profile_path"] as? String else { return nil }
        
        self.name = name
        self.id = id
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/w185\(profilePath)") {
            self.imageURL = imageURL
        } else {
            self.imageURL = nil
        }
    }
}
