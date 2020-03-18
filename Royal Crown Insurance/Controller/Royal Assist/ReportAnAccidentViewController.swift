//
//  ReportAnAccidentViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/14/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit

class ReportAnAccidentViewController: CustomNavigationBarVC {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var carRegNoTextField: UITextField!
    @IBOutlet weak var telNoTextField: UITextField!
    @IBOutlet weak var reportAccident: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var report: Report?
    var image = [UIImage(named: "add_photo_icon")]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        reportAccident.alpha = 0.5
        reportAccident.isUserInteractionEnabled = false
        nameTextField.addBottomBorder()
        carRegNoTextField.addBottomBorder()
        telNoTextField.addBottomBorder()
        dismissKey()
//        addTapGestureToHideKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        reportAccident.layer.cornerRadius = reportAccident.frame.size.height/2
        reportAccident.widthAnchor.constraint(equalToConstant: reportAccident.frame.width + 10).isActive = true
        navigationItem.title = "Accident report"
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func reportAccident(_ sender: Any) {
        guard nameTextField.text != "" else {
            showAlert(title: "Error", message: "Enter name")
            return
        }
        guard carRegNoTextField.text != "" else {
            showAlert(title: "Error", message: "Enter Car. Reg. No. / Policy NO")
            return
        }
        guard telNoTextField.text?.count == 7 else {
            showAlert(title: "Error", message: "Incorrectly entered number")
            return
        }
        report?.carRegNo = carRegNoTextField.text
        report?.name = nameTextField.text
        report?.telNo = telNoTextField.text
        for image in image {
            report?.images.append(image?.jpegData(compressionQuality: 1))
        }
    }

    @IBAction func agreeSwich(_ sender: UISwitch) {
        if sender.isOn {
            reportAccident.alpha = 1
            reportAccident.isUserInteractionEnabled = true
        } else {
            reportAccident.alpha = 0.5
            reportAccident.isUserInteractionEnabled = false
        }
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton  = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}

extension ReportAnAccidentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell",
                                                             for: indexPath) as? ImageCollectionViewCell {
            print(indexPath.row)
            itemCell.imageView.image = image[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let alertController = UIAlertController(title: "Photo Source",
                                                    message: "Choose a source",
                                                    preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
                self.chooseImagePickerAction(source: .camera)
            }
            let photoLibAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
                self.chooseImagePickerAction(source: .photoLibrary)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cameraAction)
            alertController.addAction(photoLibAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            image.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
        }
    }
}

extension ReportAnAccidentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        image.append(info[UIImagePickerController.InfoKey.editedImage] as? UIImage)
        let indexPath = IndexPath(row: image.count-1, section: 0) //at some index
        self.collectionView.insertItems(at: [indexPath])
           dismiss(animated: true, completion: nil)
       }

    func chooseImagePickerAction(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}
extension UIViewController {
    func dismissKey() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
