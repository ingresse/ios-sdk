//
//  AphButton.swift
//  IngresseSDK
//
//  Created by Marcelo Bissuh on 01/09/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    @IBInspectable
    var roundRadius: Bool {
        get {
            return layer.cornerRadius == frame.height/2
        }
        set {
            layer.cornerRadius = (newValue ? frame.height/2 : 0)
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
}

@IBDesignable
class AphButton: UIButton {}
