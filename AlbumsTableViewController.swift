//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Chuck Harpke on 11/29/15.
//  Copyright © 2015 Chuck Harpke. All rights reserved.
//

import UIKit
import Photos

class AlbumsTableViewController: UITableViewController {
    
    
    var albumsCollection = PHFetchResult()
    var assetsCollection = PHAssetCollection()
    var photoAsset = PHFetchResult()
    
    var albumNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        albumsCollection = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.Album, subtype: PHAssetCollectionSubtype.Any, options: nil)
        
        //print(albumsCollection.count)
        
        if albumsCollection.count > 0 {
            
            for i in 0...albumsCollection.count - 1 {
                
                assetsCollection = albumsCollection[i] as! PHAssetCollection
                //print(assetsCollection)
                
                let albumName = assetsCollection.localizedTitle!
                albumNames.append(albumName)
                
            }
            
            //print(albumNames)
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return albumNames.count > 0 ? 1 : 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumNames.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! AlbumsTableViewCell
        
        assetsCollection = albumsCollection[indexPath.row] as! PHAssetCollection
        photoAsset = PHAsset.fetchAssetsInAssetCollection(assetsCollection, options: nil)
        
        
        if photoAsset.count > 0 {
            
            let totalImages = photoAsset.count
            
            let randomIndex: Int = Int(arc4random_uniform(UInt32(photoAsset.count)))
            let asset: PHAsset = photoAsset[randomIndex] as! PHAsset
            
            PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.AspectFit, options: nil, resultHandler: { (image: UIImage?, object: [NSObject: AnyObject]?) -> Void in
                
                cell.albumImage.image = image
                cell.albumCount.text = totalImages > 1 ? "\(totalImages) Images" : "\(totalImages) Image"
                
            })
            
            
        } else {
            
            cell.albumImage.image = UIImage(named: "imagePlaceholder")
            cell.albumCount.text = "0 Images"
            
        }
        
        cell.albumName.text = albumNames[indexPath.row]
        
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showAlbums" {
            
            let controller: ViewController = segue.destinationViewController as! ViewController
            let indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow!
            
            controller.albumName = albumNames[indexPath.row]
            assetsCollection = albumsCollection[indexPath.row] as! PHAssetCollection
            controller.assetsCollection = assetsCollection
            
            
            controller.photoAssets = PHAsset.fetchAssetsInAssetCollection(assetsCollection, options: nil)
            
            
        }
        
    }
    
    
}
