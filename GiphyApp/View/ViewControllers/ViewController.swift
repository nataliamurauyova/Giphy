//
//  ViewController.swift
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/21/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate  {
    
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    

    
    
    let viewModel = GifViewModel()
    var dataSource = [Gif?]()
    
    var offset = 0
    
    @IBAction func filterButtonClicked(_ sender: Any) {
        self.viewModel.rating = "pg"
        let alert = UIAlertController(title: "Now your gifs are family friendly😉", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


       self.collectionView.delegate = self
       self.collectionView.dataSource = self
       self.searchBar.delegate = self
        
       self.navigationController?.navigationBar.barTintColor = UIColor.gray
        guard let arrayWithGifs = self.viewModel.getGifArrayFromJSON(fromURL: constantUrls.kTrendingUrl) else {return}
        self.dataSource = arrayWithGifs
       //self.dataSource = self.viewModel.getGifArrayFromJSON(fromURL: constantUrls.kTrendingUrl)!
        

    }
    
    //MARK: UISearchBarDelegate methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let vc = GiphySearchViewController()
        self.navigationController?.pushViewController(vc, animated: false)
        vc.navTitle = searchBar.text!
        vc.viewModel.rating = self.viewModel.rating
        print("Rating  - \(self.viewModel.rating)")
        //self.searchBar.endEditing(true)
    }
    
    //MARK: UICollectionViewDelegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellConstant.kReuseIdentifier, for: indexPath) as! TrendingCollectionViewCell
        
        
    
        cell.backgroundColor = UIColor.purple
        self.loadGifsWithoffset(indexPath)
        self.showGif(indexPath: indexPath, cell: cell)
        
        return cell
    }
    
    //MARK: UICollectionViewDelegateFlowLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width = Int((self.view.frame.size.width/2) - 15)
        var height = self.dataSource[indexPath.row]?.sizes.height
        if (height! > 200){
            height = 170
        }
        return CGSize(width: width  , height: height!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    func loadGifsWithoffset(_ indexPath: IndexPath) {
        let count = self.dataSource.count - 3
        if (indexPath.row == count){
            self.offset += 25
            let url: String = "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC&offset=\(self.offset))"
//            let arrayWithGifs = self.viewModel.getGifArrayFromJSON(fromURL: url)
//            if (arrayWithGifs![indexPath.row].urls.smallURL != nil){
//                self.dataSource = arrayWithGifs!
//            } else {
//               arrayWithGifs![indexPath.row].urls.smallURL = "https://media2.giphy.com/media/1AgUUXI6Lqm5QHciLX/giphy-preview.gif?cid=e1bb72ff5b8d38c663362e30771c9ca6"
//            }
            //self.dataSource = arrayWithGifs
            self.dataSource = self.viewModel.getGifArrayFromJSON(fromURL: url)!
            
            
            var indexes = [IndexPath]()
            for idx in (self.dataSource.count)-25..<(self.dataSource.count) {
                indexes.append(IndexPath(item: idx, section: 0))
            }
            self.collectionView.insertItems(at: indexes)
        }
    }
    
    //MARK: Prepare for segue method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {

            if let sender = sender as? TrendingCollectionViewCell{
                let indexPath = self.collectionView.indexPath(for: sender)
                let destVC = segue.destination as! DetailGifViewController
                destVC.viewModel.title = (self.dataSource[(indexPath?.row)!]?.title!)!
                destVC.viewModel.largeUrlGif = (self.dataSource[(indexPath?.row)!]?.urls.largeURL!)!
                destVC.viewModel.date = (self.dataSource[(indexPath?.row)!]?.dates.importing!)!
                destVC.viewModel.trendingDate = (self.dataSource[(indexPath?.row)!]?.dates.trending!)!
            }
        }
    }
    func showGif(indexPath: IndexPath, cell: UICollectionViewCell)  {
        if  let locationUrl = self.dataSource[indexPath.row]?.urls.locationURL{
            guard let location = URL(string: locationUrl) else{ return }
            let data = try? Data(contentsOf: location)
            
            let image = UIImage.gif(data: data!)
            
//            cell.trendImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
//
//            cell.trendImageView.image = image
            
            let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
            myImageView.image = image
            cell.addSubview(myImageView)
            
        } else{
            self.viewModel.fetchGifsForTrends(url: (self.dataSource[indexPath.row]?.urls.smallURL!)!) { (data, destinationURL) in
                DispatchQueue.main.async {[weak self] in
                    self?.dataSource[indexPath.row]?.urls.locationURL = destinationURL.absoluteString
                    let image = UIImage.gif(data: data)
                    let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
                    myImageView.image = image
                    cell.addSubview(myImageView)
                    
//                    cell.trendImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
//                    cell.trendImageView.image = image
                }
            }
        }
    }

}

