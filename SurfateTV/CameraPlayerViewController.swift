//
//  CameraPlayerViewController.swift
//  SurfateTV
//
//  Created by Pablo Surfate on 10/19/15.
//  Copyright © 2015 Pablo Paciello. All rights reserved.
//

import UIKit
import AVKit

class CameraPlayerViewController: UIViewController {
    
    var playerVC = AVPlayerViewController()
    var cameraURL = NSURL()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        playerVC.player = AVPlayer(URL: cameraURL)
        playerVC.player?.play()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PlayCamera" {
            playerVC = (segue.destinationViewController as? AVPlayerViewController)!
        }
    }
}
