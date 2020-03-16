//
//  TextFieldExtention.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/16/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
    func isEditingAddBoider(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = CGColor(srgbRed: 48/255, green: 43/255, blue: 128/255, alpha: 1)
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
