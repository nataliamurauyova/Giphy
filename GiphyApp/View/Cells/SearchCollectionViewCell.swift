//
//  SearchCollectionViewCell.swift
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/28/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    var myImageView: UIImageView = {
        let imageV = UIImageView(frame: CGRect.zero)
        return imageV
    }()
    
    override init(frame: CGRect) {
        //self.myImageView = UIImageView(frame: CGRect.zero)
        super.init(frame: frame)
        //self.myImageView = UIImageView(frame: CGRect.zero)
        self.addSubview(myImageView)
    }
    
    func addMySub()  {
        self.addSubview(self.myImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
