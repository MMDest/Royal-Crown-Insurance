//
//  RoyalPaymentViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/14/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class RoyalPaymentViewController: CustomNavigationBarVC {
    @IBOutlet weak var viewWeb: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        let url = URL(string: "https://www.jccsmart.com/e-bill/9634031")
        let urlRequest = URLRequest(url: url!)
        viewWeb.load(urlRequest)
        SVProgressHUD.dismiss()
        navigationItem.title = "Royal payment"
    }
}
