//
//  Server.swift
//  Flicks
//
//  Created by Gelei Chen on 22/1/2016.
//  Copyright © 2016 geleichen. All rights reserved.
//

import Foundation

struct ServerConstant {
    static let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    static let now_playing = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)"
    static let top_rated = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)"
    static let imageUrl = "https://image.tmdb.org/t/p/w342"
    
    static func getUrlByPage(page:String) -> String{
        return now_playing + "&page=\(page)"
    }
    static func getTopRatedByPage(page:String) -> String{
        return top_rated + "&page=\(page)"
    }
    
    static func getImageUrlByPath(path:String?) -> String{
        if path != nil {
            return imageUrl + path!
        } else {
            return imageUrl
        }
    }
}

