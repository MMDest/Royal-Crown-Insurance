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
        Menu(name: "ROYAL ASSITS", imageName: "royal_assist_image"),
        Menu(name: "ROYAL PAYMENT", imageName: "royal_payment_image"),
        Menu(name: "WHAT TO DO IF", imageName: "what_to_do_if_image"),
        Menu(name: "SERVICES", imageName: "services_image"),
        Menu(name: "ABOUT", imageName: "about_image"),
        Menu(name: "QUESTIONNARIES", imageName: "questionnaries_image")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        collectionView.dataSource = self
        collectionView.delegate  = self
        let mainLogo = UIImage(named: "main_logo")
        let mainLogoView = UIImageView(image: mainLogo)
        mainLogoView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = mainLogoView
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back_icon")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back_icon")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                style: UIBarButtonItem.Style.plain,
                                                                target: nil, action: nil)
    }
    @objc func backToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
        case "ROYAL ASSITS":
            self.performSegue(withIdentifier: "showRoyalAssistVC", sender: nil)
        case "ROYAL PAYMENT":
            self.performSegue(withIdentifier: "showRoyalPaymentVC", sender: nil)
        case "WHAT TO DO IF":
            self.performSegue(withIdentifier: "showWhatToDoIfVC", sender: nil)
        case "SERVICES":
            self.performSegue(withIdentifier: "showServicesVC", sender: nil)
        case "ABOUT":
            self.performSegue(withIdentifier: "showAboutVC", sender: nil)
        case "QUESTIONNARIES":
            self.performSegue(withIdentifier: "showQuestionnariesVC", sender: nil)
        default:
            return
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.item + 1) % 3 == 0 {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3 - 10)
        }
        return CGSize(width: (collectionView.frame.width/2) - 5, height: collectionView.frame.height/3 - 10)
    }
}
