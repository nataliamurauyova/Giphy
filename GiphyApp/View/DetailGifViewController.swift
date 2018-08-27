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
    @IBOutlet var logoImageView: UIImageView!
    var textL = String()
    var viewModel = GifViewModel()
    
    //var gif = Gif.init(smallURL: nil, largeURL: nil, title: nil, pubDate: nil, trendingDate: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = self.viewModel.title
        self.pubDateLabel.text = self.viewModel.date
        self.logoImageView.image = UIImage(named: "logo.png")
        DispatchQueue.global().async {
            let url = URL(string: self.viewModel.largeUrlGif)
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.highResolusionImageView.image = UIImage.gif(data: data!)
            }
        }

       
    }

    
    



}
