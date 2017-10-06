//
//  AphTextField.swift
//  IngresseSDK
//
//  Created by Marcelo Bissuh on 01/09/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class AphTextField: UITextField {

    override func draw(_ rect: CGRect) {
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: (157/255), green: (166/255), blue: (173/255), alpha: 1).cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        
    }
    
}
