//
//  ViewController.swift
//  CoreDataSaveImageDemo
//
//  Created by ZhangAo on 15-3-20.
//  Copyright (c) 2015年 zhangao. All rights reserved.
//

import UIKit
import CoreData

@objc(ImageEntity)
class ImageEntity: NSManagedObject {
    @NSManaged var imageData: NSData
}

class ViewController: UIViewController {

    @IBOutlet private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveImageToCoreData() {
        let delegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = delegate.managedObjectContext
        
        let imageData = UIImagePNGRepresentation(UIImage(named: "image"))
        
        let imageEntity = NSEntityDescription.entityForName("ImageEntity", inManagedObjectContext: context!)
        let image = ImageEntity(entity: imageEntity!, insertIntoManagedObjectContext: context!)
        image.imageData = imageData
        
        var error: NSError?
        if context!.save(&error) == false {
            println("failed: \(error!.localizedDescription)")
        }
    }
    
    @IBAction func loadImageFromCoreData() {
        let delegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = delegate.managedObjectContext
        
        let request = NSFetchRequest(entityName: "ImageEntity")
        var error: NSError?
        let imageEntities = context?.executeFetchRequest(request, error: &error)
        
        let imageEntity = imageEntities?.first! as ImageEntity
        self.imageView.image = UIImage(data: imageEntity.imageData)
    }
}

