//
//  ServerMethod.swift
//  Flicks
//
//  Created by Gelei Chen on 22/1/2016.
//  Copyright © 2016 geleichen. All rights reserved.
//

import Foundation

class ServerMethod {
    static let sharedInstance = ServerMethod()
    
    let manager = NetWorkManager()
    
    func getNowPlaying(completeBlock: (NSMutableArray) -> Void, failed: (NSError) -> Void){
        let result : NSMutableArray = []
        manager.GET(ServerConstant.now_playing, parameters: nil, success: { (op:AFHTTPRequestOperation, response:AnyObject) -> Void in
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
    
    func getNowPlayingByPage(page:String,completeBlock: (NSArray) -> Void, failed: (NSError) -> Void){
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
    
    func getTopRated(completeBlock: (NSMutableArray) -> Void, failed: (NSError) -> Void){
        let result : NSMutableArray = []
        manager.GET(ServerConstant.top_rated, parameters: nil, success: { (op:AFHTTPRequestOperation, response:AnyObject) -> Void in
            let callback = MovieTopRated.mj_objectWithKeyValues(response)
            for element in callback.results {
                let movie = MovieNowPlayingCallback_result.mj_objectWithKeyValues(element)
                result.addObject(movie)
            }
            completeBlock(result)
            }) { (op:AFHTTPRequestOperation?, error:NSError) -> Void in
                failed(error)
        }
    }
    func getTopRatedByPage(page:String,completeBlock: (NSArray) -> Void, failed: (NSError) -> Void){
        var result : [MovieNowPlayingCallback_result] = []
        manager.GET(ServerConstant.getTopRatedByPage(page), parameters: nil, success: { (op:AFHTTPRequestOperation, response:AnyObject) -> Void in
            let callback = MovieTopRated.mj_objectWithKeyValues(response)
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
