//
//  ViewController.swift
//  Auto Image Flipper
//
//  Created by Sina Khalili on 5/20/16.
//  Copyright © 2016 Sina Khalili. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AutoImageFlipperDelegate {

    @IBOutlet weak var autoImageFlipper: AutoImageFlipper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        autoImageFlipper.delegate = self
        autoImageFlipper.addImage(UIImage(named: "image1")!)
        autoImageFlipper.addImage(UIImage(named: "image3")!)
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    func autoImageFlipper(autoImageFlipper: AutoImageFlipper, lastPlayed: Int) -> UIImage? {

        // This function calls when the image is fading out and next image is going to play
        // If we pass any UIImage here, the next image will be what we passed, else the flipper will check the images we have added to it before
        
        // last played is the index of image played from list or -1 if it's passed from here

        // we want to change the direction when all images of our list where played
        if lastPlayed == autoImageFlipper.images.count - 1 {
            if autoImageFlipper.moveDirection == .Left {
                autoImageFlipper.moveDirection = .Right
            } else {
                autoImageFlipper.moveDirection = .Left
            }
        }

        // to test passing images from here
        if lastPlayed == 0 {
            return UIImage(named: "image2")
        }
        return nil
    }

}

