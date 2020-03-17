//
//  AboutRoyalAssistViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/14/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit
import WebKit

class AboutRoyalAssistViewController: CustomNavigationBarVC, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    var aboutRoyal = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        requesqAboutRoyalAssist()
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = "About royal assist"
        webView.loadHTMLString(self.aboutRoyal, baseURL: nil)
    }
    fileprivate func requesqAboutRoyalAssist() {
        let url =  URL(string: "http://31.131.21.105:82/api/v1/about_royal_assist")
        let task = URLSession.shared.dataTask(with: url!) { (data, _, error) in
            if error != nil {
                print("Error")
                let alert = UIAlertController(title: "Error", message: "The request tined out", preferredStyle: .alert)
                let okButton  = UIAlertAction(title: "OK", style: .default) { (_) in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                if let content = data {
                    do {
                        let myJson = try JSONSerialization.jsonObject(with: content, options:
                            JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        let aboutRoyalAssist = myJson["about_royal_assist"] as? String
                        print(aboutRoyalAssist!)
                        self.aboutRoyal = """
                        <span style="font-size: 36pt; color: #302B80;">\(aboutRoyalAssist!)</span>
                        """
                        print(self.aboutRoyal)
                        return
                    } catch {
                    }
                }
            }
        }
        task.resume()
    }

}
