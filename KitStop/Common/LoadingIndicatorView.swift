//
//  LoadingIndicatorView.swift
//  KitStop
//
//  Created by sasha ataman on 30.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit

class LoadingIndicatorView {
    
    static var currentOverlay : UIView?
    static var blurView: UIVisualEffectView!
    static var vibrancyView: UIVisualEffectView!
    fileprivate static var patternImage: Bool = false
    fileprivate static var overlayTarget: UIView?
    
    static func show() {
        guard let currentMainWindow = UIApplication.shared.keyWindow else {
            print("No main window.")
            return
        }
        show(currentMainWindow, false)
    }
    
    static func show(_ loadingText: String) {
        guard let currentMainWindow = UIApplication.shared.keyWindow else {
            print("No main window.")
            return
        }
        show(currentMainWindow, loadingText: loadingText, patternImage: false)
    }
    
    static func show(_ overlayTarget : UIView,_ patternImage: Bool) {
        show(overlayTarget, loadingText: nil, patternImage: patternImage)
    }
    
    static func show(_ overlayTarget : UIView, loadingText: String?, patternImage: Bool) {
        // Clear it first in case it was already shown
        hide()
        let blurEffectStyle: UIBlurEffectStyle = .light
        var blurEffect: UIBlurEffect!
        blurEffect = UIBlurEffect(style: blurEffectStyle)
        blurView = UIVisualEffectView(effect: blurEffect)
        
        
        vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        
        blurView.frame = overlayTarget.frame
        vibrancyView.frame = overlayTarget.frame
        
        // Create the overlay
        let overlay = UIView(frame: overlayTarget.frame)
        overlay.center = overlayTarget.center
        if patternImage {
            overlay.alpha = 1
            let imageView = UIImageView(frame: overlay.frame)
            imageView.center = overlay.center
            imageView.image = UIImage(named: "background")
            overlay.addSubview(imageView)
        } else {
            overlay.backgroundColor = UIColor.black
            overlay.alpha = 0.5
        }
        overlayTarget.addSubview(overlay)
        overlayTarget.addSubview(vibrancyView)
        overlayTarget.addSubview(blurView)
        overlayTarget.bringSubview(toFront: blurView)
        
        
        // Create and animate the activity indicator
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        indicator.center = overlay.center
        indicator.startAnimating()
        blurView.addSubview(indicator)
        
        // Create label
        if let textString = loadingText {
            let label = UILabel()
            label.text = textString
            label.textColor = UIColor.white
            label.sizeToFit()
            label.center = CGPoint(x: indicator.center.x, y: indicator.center.y + 30)
            blurView.addSubview(label)
        }
        
        // Animate the overlay to show
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
       // overlay.alpha = overlay.alpha > 0 ? 0 : 0.5
        UIView.commitAnimations()
        
        self.patternImage = patternImage
        self.overlayTarget? = overlayTarget
        
        currentOverlay = overlay
    }
    
    static func hide() {
        if currentOverlay != nil {
            currentOverlay?.removeFromSuperview()
            if self.patternImage {
                overlayTarget?.isHidden = true
            }
            blurView.removeFromSuperview()
            vibrancyView.removeFromSuperview()
            currentOverlay =  nil
        }
    }
}
