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
    var searchQuery = String()
    
    var offset = 0
    var viewModel = GifViewModel()
    var dataSource = [Gif]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setCollectionView()
        self.navigationItem.title = self.navTitle
        var query: String = self.navTitle.lowercased()
        query = self.checkSpacesInQuery(query: query)
        self.searchQuery = query
        

        self.dataSource = self.viewModel.getGifArrayFromJSON(fromURL: "\(constantUrls.kSearchUrl)\(query)&api_key=\(constantUrls.apiKey)&rating=\(self.viewModel.rating)")!
        self.addAlertControllerIfNeeded()
 
        
    }
    
    //MARK: UICollectionViewDelegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SearchCollectionViewCell

        self.loadGifsWithoffset(indexPath, on: collectionView)
        cell.backgroundColor = UIColor.purple
        self.showGif(indexPath: indexPath, cell: cell)

        return cell
    }
     //MARK: UICollectionViewDelegateFlowLayout methods
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
            let width = Int((self.view.frame.size.width/2) - 15)
            var height = self.dataSource[indexPath.row].sizes.height
            if (height > 200){
                height = 170
            }
            
            return CGSize(width: width  , height: height)
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10.0
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

                let destVC = SearchDetailViewController(nibName: "SearchDetailViewController", bundle: nil)
                destVC.viewModel.title = self.dataSource[(indexPath.row)].title!
                destVC.viewModel.largeUrlGif = self.dataSource[(indexPath.row)].urls.largeURL!
                destVC.viewModel.date = self.dataSource[(indexPath.row)].dates.importing!
                destVC.viewModel.trendingDate = self.dataSource[indexPath.row].dates.trending!
        
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func setCollectionView()  {
        let layout = UICollectionViewFlowLayout()
        let insetLeft: CGFloat = 5.0
        let insetRight: CGFloat = 5.0
        layout.sectionInset = UIEdgeInsets(top: 10, left: insetLeft, bottom: 5, right: insetRight)
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 10.0
        
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.black
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: cellConstant.kReuseIdentifier )
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func loadGifsWithoffset(_ indexPath: IndexPath, on collectionView: UICollectionView) {
        let count = self.dataSource.count - 2
        if (indexPath.row == count){
            self.offset += 25
            let url: String = "\(constantUrls.kSearchUrl)\(self.searchQuery)&api_key=\(constantUrls.apiKey)&offset=\(self.offset)rating=\(self.viewModel.rating))"
            self.dataSource = self.viewModel.getGifArrayFromJSON(fromURL: url)!
            var indexes = [IndexPath]()
            for idx in (self.dataSource.count)-25..<(self.dataSource.count) {
                indexes.append(IndexPath(item: idx, section: 0))
            }
            collectionView.insertItems(at: indexes)
        }
    }
    func addAlertControllerIfNeeded()  {
        if (self.dataSource.count == 0) {
            let alert = UIAlertController(title: "Sorry, we can't find gifs that fit your query:(", message: "Check it, please.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.navigationItem.title = ""
            
        }
    }

        func checkSpacesInQuery(query:String) -> String {
            var query = query
            if (query.contains(" ")){
                query = query.replacingOccurrences(of: " ", with: "+")
            }
            return query
        }
    func showGif(indexPath: IndexPath, cell: UICollectionViewCell)  {
        if  let locationUrl = self.dataSource[indexPath.row].urls.locationURL{
            guard let location = URL(string: locationUrl) else{ return }
            let data = try? Data(contentsOf: location)
            
            let image = UIImage.gif(data: data!)
            
            let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
            myImageView.image = image
            cell.addSubview(myImageView)
            
        } else{
            self.viewModel.fetchGifsForTrends(url: self.dataSource[indexPath.row].urls.smallURL!) { (data, destinationURL) in
                DispatchQueue.main.async {[weak self] in
                    self?.dataSource[indexPath.row].urls.locationURL = destinationURL.absoluteString
                    let image = UIImage.gif(data: data)
                    let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
                    myImageView.image = image
                    cell.addSubview(myImageView)
                }
            }
        }
    }

}
