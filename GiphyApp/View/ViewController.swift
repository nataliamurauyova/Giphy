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
    var dataSource = [Gif]()
    
    override func viewDidLoad() {
        super.viewDidLoad()


       self.collectionView.delegate = self
       self.collectionView.dataSource = self
       self.searchBar.delegate = self
        
       self.navigationController?.navigationBar.barTintColor = UIColor.gray
    
        
            for i in stride(from: 0, to: 500, by: 25) {
                self.dataSource = self.viewModel.getGifArrayFromJSON(fromURL: "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC&offset=\(i-1)")!
            }
       

        
    }
    
    //MARK: UISearchBarDelegate methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let vc = GiphySearchViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    
        vc.navTitle = searchBar.text!
        
    }
    
    //MARK: UICollectionViewDelegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TrendingCollectionViewCell
    
        cell.backgroundColor = UIColor.purple
        
        let downloader = Downloader()
        downloader.fetchGif(withUrl: self.dataSource[indexPath.row].smallURL) { (data, destination) in

                        DispatchQueue.main.async {
                            //let dataA = try? Data(contentsOf: destination!)
                            let image = UIImage.gif(url: (destination?.absoluteString)!)
                            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
                            imageView.image = image
                            cell.addSubview(imageView)
                        }
        }
//
//
//        downloader.download(fromLink: self.dataSource[indexPath.row].smallURL) { (data) in
//            DispatchQueue.main.async {
//                let image = UIImage.gif(data: data!)
//                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
//                imageView.image = image
//                cell.addSubview(imageView)
//            }
//        }
//        let fm = GiphyFileManager()
//        fm.loadURL(self.dataSource[indexPath.row].smallURL) { (destination) in
//            DispatchQueue.main.async{
//                let image = UIImage.gif(url: destination!)
//                                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
//                                imageView.image = image
//                                cell.addSubview(imageView)
//            }
//        }

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
    
    //MARK: Prepare for segue method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {

            if let sender = sender as? TrendingCollectionViewCell{
                let indexPath = self.collectionView.indexPath(for: sender)
                let destVC = segue.destination as! DetailGifViewController
                destVC.viewModel.title = self.dataSource[(indexPath?.row)!].title!
                destVC.viewModel.largeUrlGif = self.dataSource[(indexPath?.row)!].largeURL!
                destVC.viewModel.date = self.dataSource[(indexPath?.row)!].pubDate!
                destVC.viewModel.trendingDate = self.dataSource[(indexPath?.row)!].trendingDate!
            }
            
            print("Tapped!!!!")
            
        }
    }
    
   

}

