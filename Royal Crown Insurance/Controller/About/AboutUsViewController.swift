//
//  AboutUsViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/15/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit
import WebKit

class AboutUsViewController: CustomNavigationBarVC {

    @IBOutlet weak var webView: WKWebView!
    var aboutUs = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url =  URL(string: "http://31.131.21.105:82/api/v1/about_us")
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
                        let about = myJson["about_us"] as! String
                        print(about)
                        self.aboutUs = """
                        <span style="font-size: 36pt; color: #302B80;">\(about)</span>
                        """
                        print(self.aboutUs)
                        return
                        } catch {
                    }
                }
            }
        }
        task.resume()
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = "About us"
        webView.loadHTMLString(self.aboutUs , baseURL: nil)
    }
}
