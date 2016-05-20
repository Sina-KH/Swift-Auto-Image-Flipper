//
//  AutoImageFlipper.swift
//  Auto Image Flipper v0.6.0
//
//  Created by Sina Khalili on 5/20/16.
//  Copyright © 2016 Sina Khalili. All rights reserved.
//

import UIKit

class AutoImageFlipper: UIView {
    
    private var imageView1 = UIImageView()
    private var imageView2 = UIImageView()
    private var visibleImageView = 1
    
    private(set) var images = [UIImage]()
    private(set) var lastPlayed = -1
    private(set) var showingImage = -1
    
    private var ratioValue: CGFloat = 4/3
    var ratio : CGFloat {
        set {
            ratioValue = newValue
            setupRatio()
        }
        get {
            return ratioValue
        }
    }
    
    var fadeInTimeValue: Double = 3
    var fadeInTime : Double {
        set {
            if newValue < showTime - fadeOutTime {
                fadeInTimeValue = newValue
            } else {
                print("`FadeInTime` can't be lower than `ShowTime` - `FadeOutTime`")
            }
        }
        get {
            return fadeInTimeValue
        }
    }

    var fadeOutTimeValue: Double = 3
    var fadeOutTime : Double {
        set {
            if newValue < showTime - fadeInTime {
                fadeOutTimeValue = newValue
            } else {
                print("`FadeOutTime` can't be lower than `ShowTime` - `FadeInTime`")
            }
        }
        get {
            return fadeOutTimeValue
        }
    }
    
    var showTimeValue: Double = 10
    var showTime : Double {
        set {
            if newValue < fadeInTime + fadeOutTime {
                showTimeValue = newValue
            } else {
                print("`ShowTime` can't be lower than `FadeInTime` + `FadeOutTime`")
            }
        }
        get {
            return showTimeValue
        }
    }
    
    var moveDirection = AutoImageFlipperMoveDirection.Left

    var delegate: AutoImageFlipperDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.blackColor()
        addSubview(imageView1)
        addSubview(imageView2)
        setupRatio()
        playNext()
    }
    
    private func setupRatio() {
        imageView1.stopAnimating()
        imageView1.alpha = 0
        imageView2.stopAnimating()
        imageView2.alpha = 0

        imageView1.frame = CGRect(x: 0, y: 0, width: self.frame.height * ratio, height: self.frame.height)
        imageView2.frame = imageView1.frame
    }
    
    /**
     Prints Log if isInDebugMode
     
     - parameter string: Log
     */
    let isInDebugMode = false
    private func printIt(string: String) {
        if isInDebugMode {
            print(string)
        }
    }
    
    /**
     Run something with delay

     - parameter delay:   delay time in seconds
     - parameter closure: closure
     */
    private func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    /**
     Plays the animation of the imageView after setting it's image
     
     - parameter imageView: imageView to play the animation on
     - parameter image:     the image to show
     */
    private func playImage(imageView: UIImageView, image: UIImage) {

        // setting properties
        imageView.image = image

        if delegate != nil {
            delegate!.autoImageFlipper?(self, willPlayImage: image, onImageView: imageView)
        }
        
        printIt("AIF: willPlayImage on imageView")

        
        // moving animation
        if moveDirection == .Left {
            imageView.frame.origin.x = 0
        } else {
            imageView.frame.origin.x = -((self.frame.height * self.ratio) - self.frame.width)
        }
        UIView.animateWithDuration(self.showTime, delay: 0.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            
            if self.moveDirection == .Left {
                imageView.frame.origin.x = -((self.frame.height * self.ratio) - self.frame.width)
            } else {
                imageView.frame.origin.x = 0
            }
            
            }, completion: { (finished: Bool) -> Void in
                
        })
        
        // fade in animation
        imageView.alpha = 0
        UIView.animateWithDuration(self.fadeInTime, delay: 0.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            
            imageView.alpha = 0.7
            
            }, completion: nil)
        
        delay(self.showTime - fadeOutTime) {

            // fade out animation
            UIView.animateWithDuration(self.fadeOutTime, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                
                imageView.alpha = 0
                
                }, completion: { (finished: Bool) -> Void in
                    
                    if finished {
                        if self.delegate != nil {
                            self.delegate!.autoImageFlipper?(self, didPlayImage: image)
                        }
                    }
            })
            
            // play next
            self.playNext()
        }

    }
    
    /**
     
     *** PUBLIC API ***
     
     Plays next image on the screen (and plays first image on start)
     */
    func playNext() {

        // Check if delegate pushes any image to show
        var image: UIImage? = delegate?.autoImageFlipper(self, lastPlayed: showingImage)
        
        // If nothing is pushed from delegate, check for images
        if image == nil {

            if images.count == 0 {
                return
            }
            
            if lastPlayed < images.count - 1 {
                lastPlayed += 1
            } else {
                lastPlayed = 0
            }
        
            image = images[lastPlayed]
            showingImage = lastPlayed
            
        } else {
            showingImage = -1
        }
        
        // Now play next
        printIt("AIF now play next")
        if visibleImageView == 1 {
            visibleImageView = 2
            playImage(imageView2, image: image!)
        } else {
            visibleImageView = 1
            playImage(imageView1, image: image!)
        }
        
    }
    /**
     
     *** PUBLIC API ***
     
     Add image to show
     
     - parameter image: image
     */
    func addImage(image: UIImage) {
        images.append(image)
        if images.count == 1 {
            playNext()
        }
    }

    /**
     
     *** PUBLIC API ***
     
     Remove image at index
     
     - parameter index: index
     
     - returns: Success
     */
    func removeImageAtIndex(index: Int) -> Bool {
        if images.count > index {
            images.removeAtIndex(index)
            return true
        }
        return false
    }
    
    /**
     
     *** PUBLIC API ***
     
     Remove all images
     
     */
    func removeAllImages() {
        images.removeAll()
    }
    
}

enum AutoImageFlipperMoveDirection: Int {
    case Left = -1, Right = 1
}