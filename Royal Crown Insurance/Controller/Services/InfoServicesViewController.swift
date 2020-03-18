//
//  QuestionnariesViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/14/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit
import WebKit

class InfoServicesViewController: UIViewController {

    var infoServices = ""
    var typeServic = ""
    var services = ""
    var urlString = ""
    @IBOutlet weak var typeServices: UILabel!
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var viewWeb: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        typeServices.text = typeServic
        titleButton.setTitle(services, for: .normal)
        viewWeb.loadHTMLString("""
        <span style="font-size: 36pt; color: #302B80;">\(infoServices)</span>
        """, baseURL: nil)
        navigationItem.titleView = UIImageView(image: UIImage(named: "red_logo_icon"))
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "webView" else {return}
        let dvc = segue.destination as? WebBrowserViewController
        dvc?.webString = urlString
    }
}
