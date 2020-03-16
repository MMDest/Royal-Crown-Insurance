//
//  RoyalAssistViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/14/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit

class RoyalAssistViewController: CustomNavigationBarVC {

    @IBOutlet weak var collectionView: UICollectionView!
    let itemMenuArray: [Menu] = [
        Menu(name: "REPORT AN ACCIDENT",imageName: "report_an_accident_image"),
        Menu(name: "MAKE A CALL",imageName: "make_a_call_image"),
        Menu(name: "ABOUT ROYAL ASSIST",imageName: "about_royal_assist_image")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.dataSource = self
        collectionView.delegate  = self
        self.navigationItem.title = "Royal Assist"
         self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
}

extension RoyalAssistViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemMenuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? MenuCollectionViewCell{
                  itemCell.nameLabel.text = itemMenuArray[indexPath.row].name
                  itemCell.imageView.image = itemMenuArray[indexPath.row].image
                  return itemCell
              }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch itemMenuArray[indexPath.row].name {
        case "REPORT AN ACCIDENT":
            self.performSegue(withIdentifier: "reportAnAccidentVC", sender: nil)
        case "MAKE A CALL":
            let url = NSURL(string: "tel://77777773")!
            if UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open(url as URL)
            }
        case "ABOUT ROYAL ASSIST":
            self.performSegue(withIdentifier: "aboutRoyalAssistVC", sender: nil)
        default:
            return
        }
    }
}
extension RoyalAssistViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3 - 10)
    }
}
