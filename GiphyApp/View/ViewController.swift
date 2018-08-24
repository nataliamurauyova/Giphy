//
//  ViewController.swift
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/21/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource  {
    
    
    @IBOutlet var collectionView: UICollectionView!
    var urls = String ()
    var titles = [String] ()
    var dates = [String] ()
    var trendingDates = [String] ()
    var urlForSmallGif = [String] ()
    var urlForLargeGif = [String] ()
var gif = Gif.init(smallURL: nil, largeURL: nil, title: nil, pubDate: nil, trendingDate: nil)
    let colorsArray = [UIColor.blue, UIColor.green, UIColor.purple, UIColor.magenta]
    //var gif:Gif
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let parser = JSON_Parser()
        
        let arr: [Any?] = parser.parseJSON(fromURL: "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC")
        //print("arr  - \(arr)")
        for item in arr {
            var dict : [String:Any] = item as! [String : Any]
           
            self.titles.append(dict["title"] as! String)
            self.dates.append(dict["import_datetime"] as! String)
            self.trendingDates.append(dict["trending_datetime"] as! String)
            
            let arri: [[String:Any]] = [dict["images"] as! Dictionary<String, Any>]
            
            for image in arri {
//                var ddiicct: [String: Any] = image
                let urla: [[String:Any]] = [image["fixed_width_small"] as! Dictionary<String, Any>]
                let originalUrla: [[String:Any]] = [image["original"] as! Dictionary<String, Any>]
                for url in urla {
                    var urlDict : [String: Any] = url
                    self.urlForSmallGif.append(urlDict["url"] as! String)
                }
                for largeURL in originalUrla{
                    var largeUrl : [String: Any] = largeURL
                    self.urlForLargeGif.append(largeURL["url"] as! String)
                    self.urls.append(largeURL["url"] as! String)
                }
            }
            
            }

       self.collectionView.delegate = self
       self.collectionView.dataSource = self
       
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.urlForSmallGif.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TrendingCollectionViewCell
        self.gif = Gif(smallURL: self.urlForSmallGif[indexPath.row], largeURL: self.urlForLargeGif[indexPath.row], title: self.titles[indexPath.row], pubDate: self.dates[indexPath.row], trendingDate: self.trendingDates[indexPath.row])
        //cell.backgroundColor = colorsArray[arc4random_uniform(3)]
        cell.backgroundColor = UIColor.purple
        let downloader = Downloader()
        downloader.download(fromLink: self.urlForSmallGif[indexPath.row]) { (data) in
            DispatchQueue.main.async {
            let image = UIImage.gif(data: data!)
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
            DispatchQueue.main.async {
                imageView.image = image
            }
            cell.addSubview(imageView)
        }
        }
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailGifViewController()
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    

}
