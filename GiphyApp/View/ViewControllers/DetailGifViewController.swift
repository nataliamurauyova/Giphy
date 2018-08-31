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
    @IBOutlet var trendButton: UIButton!
    
    
    
    @IBAction func shareButtonClicked(_ sender: Any) {
        
        let data = try! Data(contentsOf: URL(string: self.viewModel.largeUrlGif)!)
        let activityVC = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    var textL = String()
    var viewModel = GifViewModel()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.trendButton.isHidden = true
        self.setUpViews()
        self.setUpMainGif()
    }

     func setUpViews(){
        let dateForLabel = String.convertDateFrom(date: self.viewModel.date)
        self.pubDateLabel.text = dateForLabel
        self.titleLabel.text = self.viewModel.title
        self.logoImageView.image = UIImage(named: "logo.png")
    }
    func setUpMainGif() {
        DispatchQueue.global().async {
            let url = URL(string: self.viewModel.largeUrlGif)
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.trendButton.isHidden = false
                self.highResolusionImageView.image = UIImage.gif(data: data!)
            }
        }

    }



}
