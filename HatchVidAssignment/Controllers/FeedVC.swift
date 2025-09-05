//
//  ViewController.swift
//  HatchVidAssignment
//
//  Created by Vikas Mehay on 2025-09-04.
//

import UIKit

class FeedVC: UIViewController {
    @IBOutlet weak var collFeed: UICollectionView!
    var videos : [URL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.collFeed.isPagingEnabled = false
        self.setupView()
        self.getFeed()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        if let layout = collFeed.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = self.view.bounds.size
//            print(self.view.bounds.size)
        }
    }
    func getFeed() {
        Network().getFeed {[weak self](videos) in
            DispatchQueue.main.async {
                self?.videos = videos
                self?.collFeed.reloadData()
            }
        }
    }
     
}

extension FeedVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.reuseIdentifier, for: indexPath) as? FeedCell {
            cell.setupCellFor(url: self.videos[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? FeedCell {
            cell.togglePlay()
        }
        // Additional pause / play
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(self.view.bounds.size)
        return self.view.bounds.size
    }
}
