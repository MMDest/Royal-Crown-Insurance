//
//  WebBrowserViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/18/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit
import WebKit

class WebBrowserViewController: UIViewController {

    var webString = ""
    @IBOutlet var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlRequest = URLRequest(url: URL(fileURLWithPath: webString))
        webView.load(urlRequest)
        navigationItem.titleView = UIImageView(image: UIImage(named: "main_logo"))
        // Do any additional setup after loading the view.
    }
}
