//
//  Actor.swift
//  MovieNight
//
//  Created by Mathias Vang Rasmussen on 23/11/2016.
//  Copyright © 2016 ReCapted. All rights reserved.
//

import Foundation

struct Genre: MovieType {
    
    let id: Int?
    let name: String?
    var selected = false
    let type = Type.genre
    
    init?(resultDecoder result: JSON) {
        guard let
            name = result["name"] as? String,
            let id = result["id"] as? Int
            else {
                return nil
        }
        self.name = name
        self.id = id
    }
}
