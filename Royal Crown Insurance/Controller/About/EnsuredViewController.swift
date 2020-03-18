//
//  EnsuredViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/17/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit
import WebKit

class EnsuredViewController: CustomNavigationBarVC {

    @IBOutlet weak var viewWeb: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.royalcrowninsurance.com")
        let urlRequest = URLRequest(url: url!)
        viewWeb.load(urlRequest)
        navigationItem.titleView = UIImageView(image: UIImage(named: "main_logo"))
        // Do any additional setup after loading the view.
    }
}
