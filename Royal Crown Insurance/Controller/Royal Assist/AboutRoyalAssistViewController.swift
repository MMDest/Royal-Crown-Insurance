//
//  AboutRoyalAssistViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/14/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class AboutRoyalAssistViewController: CustomNavigationBarVC, WKUIDelegate {
    @IBOutlet weak var webView: WKWebView!
    var aboutRoyal = ""
    let networkManager = NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        networkManager.getAboutUs(key: "about_royal_assist", aboutUrl: "/api/v1/about_royal_assist") { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let value):
                self.aboutRoyal = value
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
        navigationItem.title = "About royal assist"
        webView.loadHTMLString(self.aboutRoyal, baseURL: nil)
    }
}
