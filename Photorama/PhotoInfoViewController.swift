//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by Yemi Ajibola on 9/12/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchImageForPhoto(photo) { (result) in
            switch result {
            case let .Success(image):
                NSOperationQueue.mainQueue().addOperationWithBlock({ 
                    self.imageView.image = image
                })
            case let .Failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
}
