//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Yemi Ajibola on 9/11/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchRecentPhotos { (photosResult) in
            switch photosResult {
            case let .Success(photos):
                print("Successfully found \(photos.count) recent photos")
                
                if let firstPhoto = photos.first {
                    self.store.fetchImageForPhoto(firstPhoto, completion: { (imageResult) in
                        switch imageResult {
                        case let .Success(image):
                            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                                self.imageView.image = image
                            })
                        case let .Failure(error):
                            print("Error downloading the image: \(error)")
                        }
                    })
                }
                
            case let .Failure(error):
                print("Error fetching recent photos: \(error)")
            }
        }
    }
}
