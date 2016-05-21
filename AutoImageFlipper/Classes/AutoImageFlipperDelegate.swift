//
//  AutoImageFlipperDelegate.swift
//  Auto Image Flipper v0.8.1
//
//  Created by Sina Khalili on 5/20/16.
//  Copyright © 2016 Sina Khalili. All rights reserved.
//

import UIKit

@objc
public protocol AutoImageFlipperDelegate {
    
    optional func autoImageFlipper(autoImageFlipper: AutoImageFlipper, willPlayImage: UIImage, onImageView: UIImageView)
    optional func autoImageFlipper(autoImageFlipper: AutoImageFlipper, didPlayImage: UIImage)

    /**
     This function is called when the image is fading out and the next image is going to fade in
     If this returns something, auto image flipper will play it first
     
     - parameter autoImageFlipper: autoImageFlipper
     - parameter lastPlayed:       lastPlayed image index, nil if it was pushed from delegate (this function)
     
     - returns: UIImage to show, nil if playing from queue is needed
     */
    func autoImageFlipper(autoImageFlipper: AutoImageFlipper, lastPlayed: Int) -> UIImage?
    
}
