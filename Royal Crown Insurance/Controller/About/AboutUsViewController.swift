//
//  AboutUsViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/15/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class AboutUsViewController: CustomNavigationBarVC {

    @IBOutlet weak var webView: WKWebView!
    var aboutUs = ""
    let networkManager = NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        sleep(1)
        SVProgressHUD.show()
        networkManager.getAboutUs(key: "about_us", aboutUrl: "/api/v1/about_us") { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let value):
                self.aboutUs = value
            case .failure(let error):
                let alert = UIAlertController(title: "Error",
                                              message: "The request timed out",
                                              preferredStyle: .alert)
                let okButton  = UIAlertAction(title: "OK", style: .default) { (_) in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                print(error)
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = "About us"
        webView.loadHTMLString(self.aboutUs, baseURL: nil)
    }
}
