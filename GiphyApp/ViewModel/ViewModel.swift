//
//  ViewModel.swift
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/22/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import Foundation

@objc class GifViewModel: NSObject {
    let title: String?
    
    
    init(gif: Gif) {
        self.title = gif.title
    }
}
