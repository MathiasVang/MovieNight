//
//  DataTypes.swift
//  MovieNight
//
//  Created by Mathias Vang Rasmussen on 23/11/2016.
//  Copyright © 2016 ReCapted. All rights reserved.
//

import Foundation

typealias JSON = [String : AnyObject]
typealias JSONDict = [String: AnyObject]
typealias Result = [[String : AnyObject]]


protocol DataType { }

protocol DataProtocol {
    var name: String { get }
    var type: DataType { get }
    init?(resultDecoder result: JSON)
}

protocol MovieType {
    var type: Type { get }
    var id: Int? { get }
    var selected: Bool { get set }
}

protocol JSONDecodable {
    init?(JSON: JSON)
}

enum Type {
    case movie
    case genre
}

