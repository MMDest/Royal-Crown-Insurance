//
//  ViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/13/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let itemMenuArray: [Menu] = [
        Menu(name: "ROYAL ASSITS",imageName: "royal_assist_image"),
        Menu(name: "ROYAL PAYMENT",imageName: "royal_payment_image"),
        Menu(name: "SERVICES",imageName: "services_image"),
        Menu(name: "WHAT TO DO IF",imageName: "what_to_do_if_image"),
        Menu(name: "ABOUT",imageName: "about_image"),
        Menu(name: "QUESTIONNARIES",imageName: "questionnaries_image")
    ]
    /*{
        var blankMenu1 = Menu(name: "ROYAL ASSITS",imageName: "royal_assist_image")
        var blankMenu2 = Menu(name: "ROYAL PAYMENT",imageName: "royal_payment_image")
        var blankMenu3 = Menu(name: "SERVICES",imageName: "services_image")
        var blankMenu4 = Menu(name: "WHAT TO DO IF",imageName: "what_to_do_if_image")
        var blankMenu5 = Menu(name: "ABOUT",imageName: "about_image")
        var blankMenu6 = Menu(name: "QUESTIONNARIES",imageName: "questionnaries_image")
        return [blankMenu1,blankMenu2,blankMenu3,blankMenu4,blankMenu5,blankMenu6]
    }()
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate  = self
        
        let mainLogo = UIImage(named: "main_logo")
        let mainLogoView = UIImageView(image: mainLogo)
        mainLogoView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = mainLogoView
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemMenuArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? MenuCollectionViewCell{
            itemCell.menu = itemMenuArray[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
    
     
}
