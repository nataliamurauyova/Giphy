//
//  GiphySearchViewController.swift
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/28/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import UIKit

class GiphySearchViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var navTitle = String()
    var viewModel = GifViewModel()
    var dataSource = [Gif]()
    //var collectionView = UICollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let myView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
//        myView.backgroundColor = UIColor.green
//        self.view.addSubview(myView)
                let layout = UICollectionViewFlowLayout()
                let insetLeft: CGFloat = 5.0
                let insetRight: CGFloat = 5.0
                layout.sectionInset = UIEdgeInsets(top: 10, left: insetLeft, bottom: 5, right: insetRight)
                layout.minimumLineSpacing = 5.0
                layout.minimumInteritemSpacing = 10.0
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.black
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
       self.navigationItem.title = self.navTitle
        let query: String = self.navTitle.lowercased()
        self.dataSource = self.viewModel.getGifArrayFromJSON(fromURL: "http://api.giphy.com/v1/gifs/search?q=\(query)&api_key=dc6zaTOxFJmzC")!
        print(self.dataSource[0].title)
        
        //self.setUpCollectionView()
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.purple
                let downloader = Downloader()
        
                downloader.download(fromLink: self.dataSource[indexPath.row].smallURL) { (data) in
                    DispatchQueue.main.async {
                        let image = UIImage.gif(data: data!)
                        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
                        imageView.image = image
                        cell.addSubview(imageView)
                    }
                }
        return cell
    }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
            let width = self.dataSource[indexPath.row].sizes.width
            let height = self.dataSource[indexPath.row].sizes.height
            return CGSize(width: (width/2) - 10 , height: height)
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10.0
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let destVC = SearchDetailViewController(nibName: "SearchDetailViewController", bundle: nil)
                destVC.viewModel.title = self.dataSource[(indexPath.row)].title!
                destVC.viewModel.largeUrlGif = self.dataSource[(indexPath.row)].largeURL!
                destVC.viewModel.date = self.dataSource[(indexPath.row)].pubDate!
                destVC.viewModel.trendingDate = self.dataSource[indexPath.row].trendingDate!
        
        
        self.navigationController?.pushViewController(destVC, animated: true)

//        print(self.dataSource[indexPath.row].title)
//        destinationVC.viewModel.title = self.dataSource[(indexPath.row)].title!
//        destinationVC.viewModel.largeUrlGif = self.dataSource[(indexPath.row)].largeURL!
//        destinationVC.viewModel.date = self.dataSource[(indexPath.row)].pubDate!
//        self.navigationController?.pushViewController(destinationVC, animated: true)
        
    }
//    let layout: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        let insetLeft: CGFloat = 5.0
//        let insetRight: CGFloat = 5.0
//        layout.sectionInset = UIEdgeInsets(top: 10, left: insetLeft, bottom: 5, right: insetRight)
//        layout.minimumLineSpacing = 5.0
//        layout.minimumInteritemSpacing = 10.0
//        //        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width / 2 - (insetLeft + insetRight), height: 140)
//        return layout
//    }()
//    func setUpCollectionView()  {
//        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
//        collectionView.backgroundColor = .black
////        collectionView.delegate = self
////        collectionView.dataSource = self
//        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
//        self.view.addSubview(collectionView)
//    }


   

}
