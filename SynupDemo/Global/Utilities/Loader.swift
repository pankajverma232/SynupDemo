//
//  Loader.swift
//  SynupDemo
//
//  Created by Pankaj Verma on 26/08/19.
//  Copyright © 2019 Pankaj Verma. All rights reserved.
//

import UIKit
class Loader {
    var overlayView : UIView!
    var activityIndicator : UIActivityIndicatorView!
    
    class var shared: Loader {
        struct Static {
            static let instance: Loader = Loader()
        }
        return Static.instance
    }
    
    private init(){
        self.overlayView = UIView()
        self.activityIndicator = UIActivityIndicatorView()
        
        overlayView.frame = CGRect(x:0, y:0, width:80, height: 80)
        overlayView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        overlayView.layer.zPosition = 1
        
        activityIndicator.frame = CGRect(x:0, y:0, width:40, height: 40)
        activityIndicator.center = CGPoint(x:overlayView.bounds.width / 2, y:overlayView.bounds.height / 2)
        activityIndicator.style = .whiteLarge
        overlayView.addSubview(activityIndicator)
    }
    
    public func show(on view: UIView) {
        overlayView.center = view.center
        view.addSubview(overlayView)
        activityIndicator.startAnimating()
    }
    
    public func hide() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}

