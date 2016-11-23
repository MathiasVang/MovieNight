//
//  MovieType.swift
//  MovieNight
//
//  Created by Mathias Vang Rasmussen on 23/11/2016.
//  Copyright © 2016 ReCapted. All rights reserved.
//

import Foundation

enum Type {
    case movie
    case actor
}

protocol MovieType {
    var type: Type { get }
    var id: Int? { get }
    var selected: Bool { get set }
    
    init?(json: JSONDict)
}
