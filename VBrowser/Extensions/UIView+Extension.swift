//
//  UIView+Extension.swift
//  VBrowser
//
//  Created by Vishal Bhadade on 12/09/20.
//  Copyright © 2020 VB. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func dropShadow(with color: UIColor?) {
        let layers:[CALayer] = layer.sublayers!
        // Removing existing layers before adding any new layer.
        for layer in layers {
            if layer.name == "shadowLayerOne" || layer.name == "shadowLayerTwo" {
                layer.removeFromSuperlayer()
            }
        }
        
        // Shadow Layer one
        let shadowLayerOne: CALayer = CALayer()
        shadowLayerOne.name = "shadowLayerOne"
        shadowLayerOne.frame = self.bounds
        shadowLayerOne.zPosition = -2.0
        shadowLayerOne.cornerRadius = 6.0
        shadowLayerOne.backgroundColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        shadowLayerOne.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        if let aColor = color {
            shadowLayerOne.shadowColor = aColor.cgColor
        }
        shadowLayerOne.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayerOne.shadowOpacity = 1.0
        shadowLayerOne.shadowRadius = 1.0
        shadowLayerOne.masksToBounds = false
        
        // Shadow Layer two
        let shadowLayerTwo: CALayer = CALayer()
        shadowLayerTwo.name = "shadowLayerTwo"
        shadowLayerTwo.frame = self.bounds
        shadowLayerTwo.zPosition = -2.0
        shadowLayerTwo.cornerRadius = 6.0
        shadowLayerTwo.backgroundColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        shadowLayerTwo.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        if let aColor = color {
            shadowLayerOne.shadowColor = aColor.cgColor
        }
        shadowLayerTwo.shadowOffset = CGSize(width: 0, height: 1)
        shadowLayerTwo.shadowOpacity = 1.0
        shadowLayerTwo.shadowRadius = 3.0
        shadowLayerTwo.masksToBounds = false
        
        layer.addSublayer(shadowLayerOne)
        layer.addSublayer(shadowLayerTwo)
    }
}
