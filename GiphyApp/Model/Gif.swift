//
//  Gif.swift
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/22/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import Foundation


class Gif {
   

        var title: String?
        var rating: String?
        var urls: Urls
        var dates:Dates
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
    

    init(urls: Urls, title: String?,rating: String?, dates: Dates, size: Size) {
        self.title = title
        self.urls = urls
        self.dates = dates
        self.sizes = size
        self.rating = rating
    }
}
