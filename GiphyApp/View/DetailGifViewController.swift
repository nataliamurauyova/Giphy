//
//  DetailGifViewController.swift
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/24/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import UIKit

class DetailGifViewController: UIViewController {

    @IBOutlet var highResolusionImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var pubDateLabel: UILabel!
    var gif = Gif.init(smallURL: nil, largeURL: nil, title: nil, pubDate: nil, trendingDate: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
