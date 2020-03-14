//
//  AboutViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/14/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let itemMenuArray: [Menu] = [
        Menu(name: "ABOUT US",imageName: "about_us_image"),
        Menu(name: "BRANCHES",imageName: "brances_image"),
        Menu(name: "E-NSURED",imageName: "ensured_image"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.dataSource = self
        collectionView.delegate  = self
        self.navigationItem.title = "About"
        self.navigationController?.navigationBar.tintColor = UIColor(red: 48/255.0,
                                                           green: 43/255.0,
                                                           blue: 128/255.0,
                                                           alpha: 1.0)

        let backButton = UIBarButtonItem(image: UIImage(named :"red_logo_icon"), style: .plain, target: self, action: #selector(backToRoot))
        backButton.tintColor = .red
        navigationItem.rightBarButtonItem = backButton
    }

    @objc func backToRoot(){
        navigationController?.popToRootViewController(animated: true)
    }
}

extension AboutViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemMenuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCelll", for: indexPath) as? MenuCollectionViewCell{
            itemCell.nameLabel.text = itemMenuArray[indexPath.row].name
            itemCell.imageView.image = itemMenuArray[indexPath.row].image
            return itemCell
        }
        return UICollectionViewCell()
    }
}
extension AboutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 190)
    }
}

