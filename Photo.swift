//
//  Photo.swift
//  Photorama
//
//  Created by Yemi Ajibola on 9/12/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit
import CoreData


class Photo: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    var image: UIImage?
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        // Give the properties their initial values
        title = ""
        photoID = ""
        remoteURL = NSURL()
        photoKey = NSUUID().UUIDString
        dateTaken = NSDate()
    }

}
