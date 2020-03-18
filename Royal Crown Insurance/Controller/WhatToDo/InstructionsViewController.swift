//
//  InstructionsViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/18/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit
import WebKit

class InstructionsViewController: UIViewController {
    var isSecondTitle = false
    var firstTitle = ""
    var secondTitle = ""
    var firstText = ""
    var secondText = ""
    var instructionText = ""
    @IBOutlet weak var tabTitle: UISegmentedControl!
    @IBOutlet weak var instructionTitle: UILabel!
    @IBOutlet weak var webView: WKWebView!
    fileprivate func custonizeTabTitle() {
        instructionTitle.text = instructionText
        var titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        tabTitle.setTitleTextAttributes(titleTextAttributes, for: .normal)
        titleTextAttributes = [NSAttributedString.Key.foregroundColor:
            UIColor(red: 48/255, green: 43/255, blue: 128/225, alpha: 1)]
        tabTitle.setTitleTextAttributes(titleTextAttributes, for: .selected)
        webView.loadHTMLString(firstText, baseURL: nil)
        if isSecondTitle == false {
            tabTitle.removeSegment(at: 1, animated: true)
            tabTitle.setTitle(firstTitle, forSegmentAt: 0)
        } else {
            tabTitle.setTitle(firstTitle, forSegmentAt: 0)
            tabTitle.setTitle(secondTitle, forSegmentAt: 1)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        custonizeTabTitle()
    }
    @IBAction func changeTitle(_ sender: UISegmentedControl) {
        switch tabTitle.selectedSegmentIndex {
        case 0:
            webView.loadHTMLString(firstText, baseURL: nil)
        case 1:
            webView.loadHTMLString(secondText, baseURL: nil)
        default:
            print("Error")
        }
    }
}
