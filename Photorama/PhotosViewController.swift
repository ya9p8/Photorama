//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Yemi Ajibola on 9/11/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        
        store.fetchRecentPhotos { (photosResult) in
            NSOperationQueue.mainQueue().addOperationWithBlock({
                switch photosResult {
                case let .Success(photos):
                    print("Successfully found \(photos.count) recent photos.")
                    self.photoDataSource.photos = photos
                case let .Failure(error):
                    self.photoDataSource.photos.removeAll()
                    print("Error fetching recent photos: \(error)")
                }
                self.collectionView.reloadSections(NSIndexSet(index: 0))
                
            })
        }
    }
}
