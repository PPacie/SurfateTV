//
//  CameraCell.swift
//  SurfateTV
//
//  Created by Pablo Surfate on 10/16/15.
//  Copyright © 2015 Pablo Paciello. All rights reserved.
//

import UIKit

class CameraCell: UICollectionViewCell {
    
    @IBOutlet weak var camImage: UIImageView?
    @IBOutlet weak var camTitle: UILabel?
    
    var surfCam: SurfCamera? {
        didSet {
            //Clean current cell content
            camImage?.image = UIImage(named: "cam-thumbnail-placeholder")
            camTitle?.text = nil
            
            //Update Camera Title
            self.camTitle?.text = self.surfCam?.camTitle
            
            //Once we get the imageData from surfCam.camImage, we proceed to update the image in the cell.
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qos , 0)) { () -> Void in
                guard let imageData = NSData(contentsOfURL: NSURL(string:(self.surfCam?.camImage)!)!) else { return }
                let image = UIImage(data:imageData)
                //Update the UI asyncrhonically in main Thread.
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.camImage?.image = image
                }
            }
        }
    }
}
