//
//  SearchDetailViewController.swift
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/29/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {

    @IBOutlet var gifImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var trendButton: UIButton!
    @IBAction func shareButtonClicked(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: [self.viewModel.largeUrlGif], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    var viewModel = GifViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.trendButton.isHidden = true
        let textFordateLabel = String.convertDateFrom(date: self.viewModel.date)
        self.titleLabel.text = self.viewModel.title
        self.dateLabel.text = textFordateLabel
       

        
        DispatchQueue.global().async {
            let url = URL(string: self.viewModel.largeUrlGif)
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                if (self.isTrendy()){
                    self.trendButton.isHidden = false
                }
                self.gifImage.image = UIImage.gif(data: data!)
            }
        }
    }

    
    func isTrendy() -> Bool {
        if(self.viewModel.trendingDate == "0000-00-00 00:00:00") {
            self.trendButton.isHidden = true
            return false
        }
        return true
    }

}
