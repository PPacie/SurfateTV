//
//  FirstViewController.swift
//  SurfateTV
//
//  Created by Pablo Surfate on 10/16/15.
//  Copyright © 2015 Pablo Paciello. All rights reserved.
//

import UIKit

class LiveCamsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: Outlets

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Model
    
    var surfCams = [SurfCamera]()
    var defaultImageSize = CGSize?()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Load the model
        surfCams = SurfCamera.loadCameras()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: CollectionView DataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return surfCams.count
    }
    
    // MARK: CollectionView Delegate Methods
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CamCell", forIndexPath: indexPath) as? CameraCell else { return UICollectionViewCell() }
        
        cell.surfCam = surfCams[indexPath.row]    
        
        return cell
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        // Get the cell.camImage size for the very first time.
        if defaultImageSize == nil {
            print("Default Image Size being SET")
            guard let indexPath = collectionView.indexPathsForVisibleItems().last else { return }
            guard let cell = collectionView.cellForItemAtIndexPath(indexPath) as? CameraCell else { return }
            defaultImageSize = cell.camImage!.frame.size
        }
        
        // Assign the default image size to the previous focused image in the collection.
        if let previousView = context.previouslyFocusedView as? CameraCell {            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                previousView.camImage?.frame.size = self.defaultImageSize!

            })
        }
        
        // Make zoom in the next collection view image.
        if let nextView = context.nextFocusedView as? CameraCell {
            let newWidth = defaultImageSize!.width + (defaultImageSize!.width * 0.02)
            let newHeight = defaultImageSize!.height + (defaultImageSize!.height * 0.02)
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                nextView.camImage?.frame.size = CGSizeMake(newWidth, newHeight)
            })
        }
    }
    
    // MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowCamera" {
            if let indexPath = (collectionView?.indexPathsForSelectedItems()?.first) {
                guard let cell = collectionView.cellForItemAtIndexPath(indexPath) as? CameraCell else { return }
                guard let CPvc = segue.destinationViewController as? CameraPlayerViewController else { return }
                guard cell.surfCam?.camURL != nil else { return }
                CPvc.cameraURL = NSURL(string: (cell.surfCam?.camURL)!)!
            }            
        }
        
        
    }
}

