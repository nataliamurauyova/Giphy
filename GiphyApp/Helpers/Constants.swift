//
//  Constants.swift
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/31/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import Foundation

struct Constants {
    static let kDataTag = "data"
    static let kTitleTag = "title"
    static let kPubDate = "import_datetime"
    static let kTrendDate = "trending_datetime"
    static let kImagesTag = "images"
    static let kPreviewTag = "preview_gif"
    static let kDownsizedTag = "downsized"
    static let kUrlTag = "url"
    static let kHeightTag = "height"
    static let kWidthtag = "width"
    static let kRatingTag = "rating"
}

struct constantUrls {
    static let kTrendingUrl = "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC&offset=0"
    static let kSearchUrl = "http://api.giphy.com/v1/gifs/search?q="
    static let apiKey = "dc6zaTOxFJmzC"
}

struct dateFormats {
    static let oldFormat = "yyyy-MM-dd HH:mm:ss"
    static let newFormat = "MMM dd,yyyy"
}
struct cellConstant {
    static let kReuseIdentifier = "Cell"
}
