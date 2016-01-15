//
//  Helper.swift
//  Flicks
//
//  Created by Gelei Chen on 8/1/2016.
//  Copyright © 2016 geleichen. All rights reserved.
//

import UIKit

//Device Info
struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

//Device Type
struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    
}

struct ServerConstant {
    static let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    static let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)"
    static let imageUrl = "https://image.tmdb.org/t/p/w342"
    
    static func getUrlByPage(page:String) -> String{
        return url + "&page=\(page)"
    }
    
    static func getImageUrlByPath(path:String?) -> String{
        if path != nil {
            return imageUrl + path!
        } else {
            return imageUrl
        }
    }
}

class ServerMethod {
    static let sharedInstance = ServerMethod()
    
    let manager = NetWorkManager()
    
    func getListOfReviews(completeBlock: (NSMutableArray) -> Void, failed: (NSError) -> Void){
        let result : NSMutableArray = []
        manager.GET(ServerConstant.url, parameters: nil, success: { (op:AFHTTPRequestOperation, response:AnyObject) -> Void in
            let callback = MovieNowPlayingCallback.mj_objectWithKeyValues(response)
            for element in callback.results {
                let movie = MovieNowPlayingCallback_result.mj_objectWithKeyValues(element)
                result.addObject(movie)
            }
            completeBlock(result)
            }) { (op:AFHTTPRequestOperation?, error:NSError) -> Void in
                failed(error)
        }
    }
    
    func getListOfReviewsByPage(page:String,completeBlock: (NSArray) -> Void, failed: (NSError) -> Void){
        var result : [MovieNowPlayingCallback_result] = []
        manager.GET(ServerConstant.getUrlByPage(page), parameters: nil, success: { (op:AFHTTPRequestOperation, response:AnyObject) -> Void in
            let callback = MovieNowPlayingCallback.mj_objectWithKeyValues(response)
            for element in callback.results {
                let movie = MovieNowPlayingCallback_result.mj_objectWithKeyValues(element)
                result.append(movie)
            }
            completeBlock(result)
            }) { (op:AFHTTPRequestOperation?, error:NSError) -> Void in
                failed(error)
        }
    }
    
    
}


