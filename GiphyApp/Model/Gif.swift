//
//  Gif.swift
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/22/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import Foundation


class Gif {
   
    
//        var smallURL: String?
//        var largeURL: String?
        var title: String?
        var rating: String?
        var urls: Urls
        var dates:Dates
//        var pubDate: String?
//        var trendingDate: String?
        var sizes: Size
    
    
    struct Size {
        var height: Int
        var width: Int
    }
    struct Dates {
        var importing: String?
        var trending: String?
    }
    struct Urls {
        var smallURL: String?
        var largeURL: String?
        var locationURL: String?
    }
    
//    init(smallURL: String, largeURL: String, title: String, pubDate: String, trendingDate:String, size: Size) {
//            self.smallURL = smallURL
//            self.largeURL = largeURL
//            self.title = title
//            self.pubDate = pubDate
//            self.trendingDate = trendingDate
//            self.sizes = size
//        }
    init(urls: Urls, title: String?,rating: String?, dates: Dates, size: Size) {
        self.title = title
        self.urls = urls
        self.dates = dates
        self.sizes = size
        self.rating = rating
    }
}
