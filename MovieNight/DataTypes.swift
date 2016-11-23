//
//  DataTypes.swift
//  MovieNight
//
//  Created by Mathias Vang Rasmussen on 23/11/2016.
//  Copyright © 2016 ReCapted. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]

protocol DataType { }

protocol DataProtocol {
    var type: DataType { get }
    init?(resultDecoder result: JSON)
}
