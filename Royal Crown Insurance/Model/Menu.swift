//
//  Model.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/13/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import Foundation
import UIKit

struct Menu {
    var name: String?
    var imageName: String?
    var image: UIImage? {
        return UIImage(named: imageName!)
    }
}
