//
//  ViewController.swift
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/21/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource  {
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    let colorsArray = [UIColor.blue, UIColor.green, UIColor.purple, UIColor.magenta]
  
    let viewModel = GifViewModel()
    var dataSource = [Gif]()
    
    override func viewDidLoad() {
        super.viewDidLoad()


       self.collectionView.delegate = self
       self.collectionView.dataSource = self
        
       self.navigationController?.navigationBar.barTintColor = UIColor.gray
      
    
    self.dataSource = self.viewModel.getGifArrayFromJSON(fromURL: "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC")!
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TrendingCollectionViewCell
       
        //cell.backgroundColor = colorsArray[arc4random_uniform(3)]
        cell.backgroundColor = UIColor.purple
        let downloader = Downloader()
//        downloader.download(fromLink: self.urlForSmallGif[indexPath.row]) { (data) in
        
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
//            if let indexPath = self.collectionView.indexPathsForSelectedItems{
//                let destVC = segue.destination as! DetailGifViewController
//                destVC.textL = self.dataSource[2].title!
//                //destVC.titleLabel.text = self.dataSource[3].title
//
//            }
            if let sender = sender as? TrendingCollectionViewCell{
                let indexPath = self.collectionView.indexPath(for: sender)
                let destVC = segue.destination as! DetailGifViewController
                destVC.viewModel.title = self.dataSource[(indexPath?.row)!].title!
                destVC.viewModel.largeUrlGif = self.dataSource[(indexPath?.row)!].largeURL!
                destVC.viewModel.date = self.dataSource[(indexPath?.row)!].pubDate!
            }
            
            print("Tapped!!!!")
            
        }
    }
    
    

}
