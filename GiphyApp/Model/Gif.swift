//
//  Gif.swift
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/22/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import Foundation


class Gif {
    open static let publicAPIKey = "dc6zaTOxFJmzC"
    
        var smallURL: String?
        var largeURL: String?
        var title: String?
        var pubDate: String?
        var trendingDate: String?
        var sizes: Size
    
    
    struct Size {
        var height: Int
        var width: Int
    }
    
    init(smallURL: String, largeURL: String, title: String, pubDate: String, trendingDate:String, size: Size) {
            self.smallURL = smallURL
            self.largeURL = largeURL
            self.title = title
            self.pubDate = pubDate
            self.trendingDate = trendingDate
            self.sizes = size
        }
  
}
