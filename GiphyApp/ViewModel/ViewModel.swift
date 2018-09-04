//
//  ViewModel.swift
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/22/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import Foundation

class GifViewModel:NSObject {
    
    open static let publicAPIKey = "dc6zaTOxFJmzC"
    let trendingURL = "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC&offset=0"
    
   
    var title: String?
    var smallUrlGif: String?
    var largeUrlGif = String()
    var date = String ()
    var trendingDate = String ()
    var height = Int ()
    var width = Int ()
    var resultArray = [Gif]()
    var gifArray = [Gif]()
    var location = String()
    var numberOfRows = Int()
    var rating = String()
    
    

    
//    func getGifArrayFromJSON(fromURL url: String) -> [Gif]? {
//        let parser = JSON_Parser()
//
//        let fullJSON: [Any] = parser.parseJSON(fromURL: url)// else {return nil}
//        print(fullJSON.count)
//        //let fullJSON: [Any]? = parser.parseJSON(fromURL: url)
//
//
//        for dict in fullJSON {
//            //var dict : [String:Any] = dict as! [String : Any]
//            let dict: [String:Any] = dict as! [String : Any]// else {return nil}
////            print(dict)
//
//            print(dict)
//
//
//            //let title = dict[Constants.kTitleTag] as! String
//            guard let title: String = dict[Constants.kTitleTag] as? String else { return nil}
//
//
//            //let date = dict[Constants.kPubDate] as! String
//            guard let trendingDate: String = dict[Constants.kTrendDate] as? String else {return nil}
//            //let trendingDate = dict[Constants.kTrendDate] as? String
//            guard let rating: String = dict[Constants.kRatingTag] as? String else {return nil}
//            //let rating = dict[Constants.kRatingTag] as! String
//
//            //guard let dataBetweenImagesTag = [dict[Constants.kImagesTag] as! Dictionary<String, Any>] else {return}
//            guard let dataBetweenImagesTag = dict[Constants.kImagesTag] as? [Dictionary<String, Any>] else {return nil}
//            //let dataBetweenImagesTag: [[String:Any]] = [(dict[Constants.kImagesTag] as? Dictionary<String, Any>)!]
//            for image in dataBetweenImagesTag {
//                guard let dataBetweenPreviewTags = image[Constants.kPreviewTag] as? [Dictionary<String, Any>] else { return nil}
//                guard let dataBetweenOriginalTags = image[Constants.kDownsizedTag] as? [Dictionary<String, Any>] else { return nil}
//                //guard let dataBetweenPreviewTags = [image[Constants.kPreviewTag] as? Dictionary<String, Any>] else {return nil}
//                //let dataBetweenOriginalTags: [[String:Any]] = [image[Constants.kDownsizedTag] as! Dictionary<String, Any>]
//                for smallUrl in dataBetweenPreviewTags {
//                    //guard let urlDict  = smallUrl as? [String:Any] else {return nil }
//                    //self.smallUrlGif = urlDict![Constants.kUrlTag] as! String
////                    guard let smallGifurl = urlDict![Constants.kUrlTag] as? String else { return nil}
//                    guard let smallGifurl = smallUrl[Constants.kUrlTag] as? String else {return nil }
//                    self.smallUrlGif = smallGifurl
//
//                    //guard let heightForGif = Int((urlDict![Constants.kHeightTag] as? String)!) else {return nil}
//                    guard let heightForGif = Int((smallUrl[Constants.kHeightTag] as? String)!) else {return nil}
//                    self.height = heightForGif
//                    //self.height = Int(urlDict![Constants.kHeightTag] as! String)!
//                    guard let widthForGif = Int((smallUrl[Constants.kWidthtag] as? String)!) else {return nil}
//                    self.width = widthForGif
//                    //self.width = Int(urlDict![Constants.kWidthtag] as! String)!
//                }
//                for largeURL in dataBetweenOriginalTags{
//                    //guard let largeGifUrls : [String : Any]? = largeURL else {return nil}
//                    //var largeDict : [String: Any] = largeURL
//                    guard let largeGifurl = largeURL[Constants.kUrlTag] as? String else {return nil}
//                    //guard let largeGifurl = largeGifUrls![Constants.kUrlTag] as? String else { return nil}
//                    //self.largeUrlGif = largeDict[Constants.kUrlTag] as! String
//                    self.largeUrlGif = largeGifurl
//                }
//            }
//
//            let sizes = Gif.Size(height: self.height, width: self.width)
//            let urls = Gif.Urls(smallURL: self.smallUrlGif, largeURL: self.largeUrlGif, locationURL: nil)
//            let dates = Gif.Dates(importing: date, trending: trendingDate)
//            //let gif = Gif(urls: urls, title: title, dates: dates, size: sizes)
//            let gif = Gif(urls: urls, title: title, rating: rating, dates: dates, size: sizes)
//
//
//        self.resultArray.append(gif)
//        }
//        return self.resultArray
//    }
    
    func getGifArrayFromJSON(fromURL url: String) -> [Gif]? {
        let parser = JSON_Parser()
        

        let fullJSON: [Any] = parser.parseJSON(fromURL: url)

        for dict in fullJSON {
            var dict : [String:Any] = dict as! [String : Any]

            let title = dict[Constants.kTitleTag] as! String

            let date = dict[Constants.kPubDate] as! String
            let trendingDate = dict[Constants.kTrendDate] as! String
            let rating = dict[Constants.kRatingTag] as! String


            let dataBetweenImagesTag: [[String:Any]] = [dict[Constants.kImagesTag] as! Dictionary<String, Any>]
            for image in dataBetweenImagesTag {
                let dataBetweenPreviewTags: [[String:Any]] = [(image[Constants.kPreviewTag] as? Dictionary<String, Any>)!]
                let dataBetweenOriginalTags: [[String:Any]] = [image[Constants.kDownsizedTag] as! Dictionary<String, Any>]
                for smallUrl in dataBetweenPreviewTags {
                    var urlDict : [String: Any] = smallUrl

                    if let smallUrl = (smallUrl[Constants.kUrlTag] as? String) {
                        self.smallUrlGif = smallUrl
                    } else {
                        self.smallUrlGif = "https://media2.giphy.com/media/1AgUUXI6Lqm5QHciLX/giphy-preview.gif?cid=e1bb72ff5b8d38c663362e30771c9ca6"
                    }


                    if let height = urlDict[Constants.kHeightTag] as? String {
                        self.height = Int(height)!
                    } else {
                        self.height = 200
                        
                    }

                }
                for largeURL in dataBetweenOriginalTags{
                    var largeDict : [String: Any] = largeURL
                    self.largeUrlGif = largeDict[Constants.kUrlTag] as! String
                }
            }

            let sizes = Gif.Size(height: self.height, width: self.width)
            let urls = Gif.Urls(smallURL: self.smallUrlGif, largeURL: self.largeUrlGif, locationURL: nil)
            let dates = Gif.Dates(importing: date, trending: trendingDate)
            //let gif = Gif(urls: urls, title: title, dates: dates, size: sizes)
            let gif = Gif(urls: urls, title: title, rating: rating, dates: dates, size: sizes)


            self.resultArray.append(gif)
        }
        return self.resultArray
    }

    func fetchGifsForTrends(url: String, completion: @escaping ((Data, URL) -> Void))  {
        let downloader = Downloader()
        downloader.fetchGif(withUrl: url) { (data, destinationURL) in
            let compData = data
            let desturl = destinationURL
            completion(compData!, desturl!)
        }
    }
    
}
