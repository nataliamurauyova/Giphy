//
//  TrendingCollectionViewCell.swift
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/24/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageview: UIImageView! = {
                let imgView = UIImageView.init(frame: .zero)
                return imgView
    }()
    
//    var trendImageView: UIImageView = {
//        let imgView = UIImageView.init(frame: .zero)
//        return imgView
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.addSubview(self.imageview)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
//    }
    
}
