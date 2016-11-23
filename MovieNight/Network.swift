//
//  Network.swift
//  MovieNight
//
//  Created by Mathias Vang Rasmussen on 23/11/2016.
//  Copyright © 2016 ReCapted. All rights reserved.
//

import Foundation

typealias JSONDict = [String: AnyObject]
typealias JSONArray = [JSONDict]

enum Endpoint: String {
    case Actor = "person"
    case Movie = "movie"
    
    fileprivate var apiKey: String {
        return "31f34208b1116237435d7479b781ac05"
    }
    
    fileprivate var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    func URL(withQueryString queryString: String??) -> Foundation.URL {
        
        switch self {
        case .Actor:
            let actorString = queryString!?.replacingOccurrences(of: " ", with: ",")
            return Foundation.URL(string: baseURL + "search/\(self.rawValue)?query=\(actorString)&api_key=\(apiKey)")!
        case .Movie: return Foundation.URL(string: baseURL + "discover/\(self.rawValue)?with_cast=\(queryString!)&api_key=\(apiKey)")!
        }
    }
}

enum APIResult {
    case success(AnyObject)
    case failure(Error)
}

struct NetworkManager {
    fileprivate let session = URLSession(configuration: .default)
    
    func requestEndpoint(_ endpoint: Endpoint, withQueryString queryString: String?, completion: @escaping (APIResult) -> Void) {
        let request = URLRequest(url: endpoint.URL(withQueryString: queryString))
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            OperationQueue.main.addOperation {
                if let error = error {
                    completion(.failure(error as NSError))
                } else if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        switch json {
                        case let object as JSONArray: completion(.success(object as AnyObject))
                        case let object as JSONDict: completion(.success(object as AnyObject))
                        default: break
                        }
                    }
                }
            }
        })
    task.resume()
    }
}

struct JSONParser {
    static func parse(json: AnyObject, forMovieType movieType: Type, completion: (_ movieType: [MovieType]) -> Void) {
        var movieTypeArray = [MovieType]()
        
        switch movieType {
        case .movie:
            if let results = json["results"] as? JSONArray {
                for json in results {
                    if let movie = Movie(json: json) {
                        movieTypeArray.append(movie)
                    }
                }
            }
        case .actor:
            if let results = json["results"] as? JSONArray {
                for json in results {
                    if let person = Actor(json: json) {
                        movieTypeArray.append(person)
                    }
                }
            }
        }
        completion(movieTypeArray)
    }
}
