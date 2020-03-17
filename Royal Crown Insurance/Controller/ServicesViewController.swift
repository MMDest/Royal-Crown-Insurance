//
//  ServicesViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/14/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit

class ServicesViewController: CustomNavigationBarVC {

    @IBOutlet weak var collectionView: UICollectionView!

    let itemMenuArray: [Menu] = [
        Menu(name: "BUSINESS", imageName: "business_image"),
        Menu(name: "PERSONALL", imageName: "personal_image")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        collectionView.dataSource = self
        collectionView.delegate  = self
        self.navigationItem.title = "Servicess"
    }
}
extension ServicesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
}

extension ServicesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: (collectionView.frame.height/2) - 5)
    }
}
