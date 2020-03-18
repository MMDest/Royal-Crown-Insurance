//
//  AboutViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/14/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit

class AboutViewController: CustomNavigationBarVC {
    @IBOutlet weak var collectionView: UICollectionView!
    let itemMenuArray: [Menu] = [
        Menu(name: "ABOUT US", imageName: "about_us_image"),
        Menu(name: "BRANCHES", imageName: "brances_image"),
        Menu(name: "E-NSURED", imageName: "ensured_image")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.dataSource = self
        collectionView.delegate  = self
        self.navigationItem.title = "About"
    }
}

extension AboutViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemMenuArray.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell",
                                                             for: indexPath) as? MenuCollectionViewCell {
            itemCell.nameLabel.text = itemMenuArray[indexPath.row].name
            itemCell.imageView.image = itemMenuArray[indexPath.row].image
            return itemCell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch itemMenuArray[indexPath.row].name {
        case "ABOUT US":
            self.performSegue(withIdentifier: "aboutUsVC", sender: nil)
        case "BRANCHES":
            self.performSegue(withIdentifier: "branchesVC", sender: nil)
        case "E-NSURED":
            self.performSegue(withIdentifier: "ensuredVC", sender: nil)
        default:
            return
        }
    }
}
extension AboutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: (collectionView.frame.height / 3) - 10)
    }
}
