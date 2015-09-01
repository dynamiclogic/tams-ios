//
//  AppDelegate.swift
//  TAMS
//
//  Created by arash on 8/16/15.
//  Copyright (c) 2015 arash. All rights reserved.
//

import UIKit
import MapKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let radious = 0.05
    
        func makeRand() -> Double{
        let lower : UInt32 = 1000000
        let upper : UInt32 = 9999999
        var randomNumber = arc4random_uniform(upper - lower) + lower
        var rand : Double = Double(randomNumber)
        rand = radious - rand / 100000000
        return Double(rand)
    }

    func addRandomAsset(title:String){
        let entityDescription = NSEntityDescription.entityForName("AssetsTable",inManagedObjectContext: managedObjectContext!)
        
        let ass = AssetEntity(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        //var ass  = NSEntityDescription.insertNewObjectForEntityForName("AssetsTable", inManagedObjectContext: self.managedObjectContext!) as! Asset
        
        ass.latitude = 38.560884 + makeRand()
        ass.longitude = -121.422357 + makeRand()
        ass.title = title
        ass.date = NSDate()
        
        
        for i in 0...5{
        var att = NSEntityDescription.insertNewObjectForEntityForName("Attributes", inManagedObjectContext: self.managedObjectContext!) as! AssetAttributeEntity
            att.attributeName = "att \(i)"
        att.attributeData = "data \(i)"
        att.asset = ass
        }
        
      
//         let att1 = NSEntityDescription.insertNewObjectForEntityForName("Attributes", inManagedObjectContext: self.managedObjectContext!) as! AssetAttribute
//        att1.attributeName = "color"
//        att1.attributeData = "red"
//        asset.attributes.setByAddingObject(att1)
        
        managedObjectContext?.save(nil)
    }
    
    func fetchFromPHP(){
        
        var datafromphpurl = NSURL(string: "http://localhost:8888/TAMS/index.php")
        if let var data: NSData = NSData(contentsOfURL: datafromphpurl!) {
            if let json: NSArray = (NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSArray){
                for item in json {
                    println(item.valueForKey("title")!, item.valueForKey("latitude")!,item.valueForKey("longitude")!)
                }
            }
        }
        
       
        
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let request = NSFetchRequest(entityName: "AssetsTable")
        var ass =   managedObjectContext!.executeFetchRequest(request, error: nil) as! [Asset]
        for a in ass{
            print(a.title)
            print(a.latitude)
            print(a.longitude)
            println(a.date)
            for aa in (a.attributes){
                
                println(aa.attributeName)
                
            }
        }

    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
         //addRandomAsset("test")
        
        //var inserturl = NSURL(string: "http://localhost:8888/TAMS/add.php?latitude=6&longitude=6&title=6")
        //var request:NSMutableURLRequest = NSMutableURLRequest(URL:inserturl! )
        //request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        //NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
        //    {
        //        (response, data, error) in
                //println(response)
        //}
        
//        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8888/TAMS/add.php")!)
//        request.HTTPMethod = "POST"
//        let postString = "latitude=8&longitude=8&title=8"
//        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
//            data, response, error in
//            
//            if error != nil {
//                println("error=\(error)")
//                return
//            }
//            
//            println("response = \(response)")
//            
//            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
//            println("responseString = \(responseString)")
//        }
//        task.resume()
       
              for i in 0...50{
            addRandomAsset("Asset \(i)")
        }
       
        
     
        
//
//        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
//        let entityDescription = NSEntityDescription.entityForName("Assets",inManagedObjectContext: managedObjectContext!)
//        let asset = Asset(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
//        
//      
//    
//        
//        asset.latitude = 38.560884 + makeRand()
//        asset.longitude = -121.422357 + makeRand()
//        asset.title = "a"
//
//        managedObjectContext?.save(nil)
//        
//        let request = NSFetchRequest(entityName: "AssetsTable")
//        let  results = managedObjectContext?.executeFetchRequest(request, error: nil) as! [Asset]
//        println(results.count)
//        for ass in results{
//                println(ass.title)
//                println(ass.latitude)
//                println(ass.longitude)
//                println(ass.date.description)
//        }
//    

        

        
//        let managedContext = self.managedObjectContext!
//        var fetchRequest = NSFetchRequest()
//        fetchRequest.entity = NSEntityDescription.entityForName("Assets",inManagedObjectContext: managedObjectContext!)
//        var error: NSError?
//        var assetsdb = managedContext.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]
//        
//    
//            for index in 0...5 {
//                let lat : Double  = 38.560884 + makeRand()
//                let lon : Double  = -121.422357 + makeRand()
//                let title: String = "NODE \(index)"
//                let location = CLLocation(latitude: lat, longitude: lon)
//                var Attributes : [AssetAttribute] = [AssetAttribute]()
//                Attributes.append( AssetAttribute(Attribute: "Category", detail: "Signs"))
//                Attributes.append( AssetAttribute(Attribute: "Type", detail: "Stop Sign"))
//                Attributes.append( AssetAttribute(Attribute: "Color", detail: "red"))
//                for i in 4...20 {
//                    Attributes.append( AssetAttribute(Attribute: "name \(i)", detail: "details \(i)"))
//                }
//                assetsdb.append(latitude:location.coordinate.latitude,
//                    longitude: location.coordinate.longitude,
//                    title: title,
//                    date: location.timestamp)
//                
//                
//                Assets.sharedInstance.addAsset(location , title: title, subtitle: location.description,Attributes: Attributes) // random ASSETS are being added
//            }
        var e: NSError?
        if !self.managedObjectContext!.save(&e) {
            println("insert error: \(e!.localizedDescription)")
            abort()
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        self.saveContext()
    }

    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "arash.TAMS" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as! NSURL
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("AssetsDB", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("TAMS.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }
    
   
}

