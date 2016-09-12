//
//  CoreDataStack.swift
//  Photorama
//
//  Created by Yemi Ajibola on 9/12/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    let managedObjectModelName: String
    
    private lazy var managedObjecModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource(self.managedObjectModelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    private var applicationdocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls.first!
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
       var coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjecModel)
        let pathComponent = "\(self.managedObjectModelName).sqlite"
        let url = self.applicationdocumentsDirectory.URLByAppendingPathComponent(pathComponent)
        
        let store = try! coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil,
            URL: url,
            options: nil)
        
        return coordinator
    }()
    
    lazy var mainQueueContext: NSManagedObjectContext = {
        let moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        moc.persistentStoreCoordinator = self.persistentStoreCoordinator
        moc.name = "Main Queue Context (UI Context)"
        
        return moc
    }()
    
    
    
    required init(modelName: String) {
        managedObjectModelName = modelName
    }
}
