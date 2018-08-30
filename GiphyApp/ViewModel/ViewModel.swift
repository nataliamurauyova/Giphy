//
//  ViewModel.swift
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/22/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import Foundation

class GifViewModel:NSObject {
    
    
    enum Tags: String {
        case title = "title"
        case datetime = "import_datetime"
    }
    var title: String? = nil
    var smallUrlGif = String()
    var largeUrlGif = String()
    var date = String ()
    var trendingDate = String ()
    var height = Int ()
    var width = Int ()
    var resultArray = [Gif]()
    
//    init(gif: Gif) {
//        self.title = gif.title
//    }
    
    func getGifArrayFromJSON(fromURL url: String) -> [Gif]? {
        let parser = JSON_Parser()
        
        let fullJSON: [Any?] = parser.parseJSON(fromURL: url)
        
        for dict in fullJSON {
            var dict : [String:Any] = dict as! [String : Any]
            
            let title = dict["title"] as! String
            
            let date = dict["import_datetime"] as! String
            let trendingDate = dict["trending_datetime"] as! String
            
            
            let dataBetweenImagesTag: [[String:Any]] = [dict["images"] as! Dictionary<String, Any>]
            for image in dataBetweenImagesTag {
                guard let dataBetweenPreviewTags: [[String:Any]]? = [image["preview_gif"] as! Dictionary<String, Any>] else { return nil}
                let dataBetweenOriginalTags: [[String:Any]] = [image["downsized"] as! Dictionary<String, Any>]
                for smallUrl in dataBetweenPreviewTags! {
                    guard var urlDict : [String: Any]? = smallUrl else {return nil }
                    self.smallUrlGif = urlDict!["url"] as! String
                    //self.height = urlDict["height"] as! Int
                    self.height = Int(urlDict!["height"] as! String)!
                    self.width = Int(urlDict!["width"] as! String)!
                }
                for largeURL in dataBetweenOriginalTags{
                    var largeDict : [String: Any] = largeURL
                    self.largeUrlGif = largeDict["url"] as! String
                }
            }
           
            var sizes = Gif.Size(height: self.height, width: self.width)
           let gif = Gif(smallURL: self.smallUrlGif, largeURL: self.largeUrlGif, title: title, pubDate: date, trendingDate: trendingDate, size:sizes )

        self.resultArray.append(gif)
        }
        
        
        return self.resultArray
        
    }
    
}
