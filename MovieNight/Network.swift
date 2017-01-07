//
//  Network.swift
//  MovieNight
//
//  Created by Mathias Vang Rasmussen on 23/11/2016.
//  Copyright © 2016 ReCapted. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

let correctURL = "https://api.themoviedb.org/3/discover/movie?api_key=31f34208b1116237435d7479b781ac05&page=1&with_genres=%2212,35,18,27,10402%22"

private let baseURL = "https://api.themoviedb.org/3/"
private let APIKey = "?api_key=31f34208b1116237435d7479b781ac05"
private let movie = "discover/movie"
private let page = "&page=1"
private let withGenre = "&with_genres=%22"
private let genre = "genre/"
private let ending = "%22"
private let imageBaseURL = "https://image.tmdb.org/t/p/w185//"

enum DownloadResult {
    case imageSucces(UIImage)
    case success([String: AnyObject])
    case failureWithError(Error)
    case failureWithString(String)
}

class DownloadClass {
    
    enum DownloadCases {
        case movie
        case genre
    }
    
    func downloadData(downloadCase: DownloadCases, id: [Int]? = nil, completion: @escaping (DownloadResult) -> Void) {
        var urlRequest: String!
        
        var genreID: String {
            var string = [String]()
            id.map { string.append(String(describing: $0)) }
            return string.joined(separator: ",")
        }
        
        print(genreID)
         
        switch downloadCase {
        case .movie:
            urlRequest = "\(baseURL)\(movie)\(APIKey)\(page)\(withGenre)\(genreID)\(ending)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        case .genre:
            urlRequest = "\(baseURL)\(genre)movie/list\(APIKey)"
        }
        
        Alamofire.request(urlRequest).responseJSON { response in
            if let error = response.result.error {
                completion(.failureWithError(error))
                return
            }
            
            guard let responseJSON = response.result.value as? [String: AnyObject] else {
                completion(.failureWithString("Invalid information received from service"))
                return
            }
            completion(.success(responseJSON))
        }
    }
    
    func downloadImage(downloadCase: DownloadCases, path: String, completion: @escaping (DownloadResult) -> Void) {
        var urlRequest: String!
        
        switch downloadCase {
        case .movie:
            urlRequest = "\(imageBaseURL)\(path)"
        case .genre:
            break
        }
        
        Alamofire.request(urlRequest).responseImage { response in
            if let error = response.result.error {
                completion(.failureWithError(error))
                return
            }
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
                completion(.imageSucces(image))
            } else {
                print("image failed")
            }
            
        }
    }
}









