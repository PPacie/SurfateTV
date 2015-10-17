//
//  FirstViewController.swift
//  SurfateTV
//
//  Created by Pablo Surfate on 10/16/15.
//  Copyright © 2015 Pablo Paciello. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: Outlets

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Model
    
    var surfCams = [SurfCamera]()
    
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
    
    // MARK: CollectionView Delegate
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CamCell", forIndexPath: indexPath) as? CameraCell else { return UICollectionViewCell() }
        
        cell.surfCam = surfCams[indexPath.row]    
        
        return cell
    }

}

