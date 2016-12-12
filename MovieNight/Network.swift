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

private let baseURL = "https://api.themoviedb.org/3/"
private let APIKey = "?api_key=31f34208b1116237435d7479b781ac05"
private let movie = "movie_credits/"
private let genre = "genre/"
private let imageBaseURL = "http://image.tmdb.org/t/p/w185//"

enum DownloadResult {
    case success([String: AnyObject])
    case failureWithError(Error)
    case failureWithString(String)
}

class DownloadClass {
    
    enum DownloadCases {
        case movie
        case genre
    }
    

    
    func downloadData(downloadCase: DownloadCases, id: Int? = nil, completion: @escaping (DownloadResult) -> Void) {
        var urlRequest: String!
         
        switch downloadCase {
        case .movie:
            urlRequest = "\(baseURL)\(genre)\(id!)/movies\(APIKey)"
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
            debugPrint(response)
            
            print(response.request)
            print(response.response)
            debugPrint(response.result)
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
            }
        }
    }
}
