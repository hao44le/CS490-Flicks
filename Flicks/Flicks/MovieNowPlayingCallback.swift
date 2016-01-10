//
//  MovieNowPlayingCallback.swift
//  Flicks
//
//  Created by Gelei Chen on 9/1/2016.
//  Copyright © 2016 geleichen. All rights reserved.
//

import Foundation

class MovieNowPlayingCallback : NSObject {
  var page : NSNumber!
  var results : NSArray!
  var dates : MovieNowPlayingCallback_dates!
  var total_pages : NSNumber!
  var total_results : NSNumber!
}

class MovieNowPlayingCallback_dates : NSObject {
  var maximum : String!
  var minimum : String!
}

