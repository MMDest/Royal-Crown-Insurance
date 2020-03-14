//
//  CustomNavigationBarVC.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/14/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit

class CustomNavigationBarVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(image: UIImage(named :"red_logo_icon"), style: .plain, target: self, action: #selector(backToRoot))
        backButton.tintColor = .red
        navigationItem.rightBarButtonItem = backButton
    }
    
    @objc func backToRoot(){
        navigationController?.popToRootViewController(animated: true)
    }
    
}
