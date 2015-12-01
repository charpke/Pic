//
//  ImageViewController.swift
//  Albums
//
//  Created by Chuck Harpke on 11/29/15.
//  Copyright © 2015 Chuck Harpke. All rights reserved.
//

import UIKit
import Photos

class ImageViewController: UIViewController {
    
    var assetCollection = PHAssetCollection()
    var assetFetchResult = PHFetchResult()
    var index: Int = 0
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let asset: PHAsset = assetFetchResult[index] as! PHAsset
        
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.AspectFit, options: nil) { (image: UIImage?, object: [NSObject: AnyObject]?) -> Void in
            
            self.imageView.image = image
            
            
        }
        
    }
    
    
    
    
    @IBAction func deleteImage(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Deleting Image", message: "Are you sure you want to delete this image?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { (alertAction: UIAlertAction) -> Void in
            
            
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({ () -> Void in
                
                let deleteRequest = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection)
                
                deleteRequest?.removeAssets([self.assetFetchResult[self.index]])
                
                }, completionHandler: { (success: Bool, error: NSError?) -> Void in
                    
                    if success {
                        print("Image deleted successfully")
                        
                    }else {
                        print(error)
                    }
                    
            })
            
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.imageView.alpha = 0.0
            })
            
            
            
            
            
            
        }))
        
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: { (alertAction: UIAlertAction) -> Void in
            print("You Pressed No")
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
