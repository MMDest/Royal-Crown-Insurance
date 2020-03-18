//
//  BranchesViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/15/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit
import GoogleMaps
import SVProgressHUD

class BranchesViewController: CustomNavigationBarVC {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    var selectMarker: GMSMarker?
    var branch: [Branch]?
    var isHide = true
    let networkManager = NetworkManager()
    fileprivate func request() {
        SVProgressHUD.show()
        networkManager.getBranch { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let value) :
                self.branch = value
            case .failure(let error) :
                let alert = UIAlertController(title: "Error",
                                              message: "The request tined out",
                                              preferredStyle: .alert)
                let okButton  = UIAlertAction(title: "OK", style: .default) { (_) in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                print(error)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        itemView.isHidden = true
        mapView.delegate = self
        request()
        navigationItem.title = "Branches"
        self.itemView.transform = self.itemView.transform.translatedBy( x: 0.0, y: 140.0)
        titleLabel.text = ""
    }
    override func viewDidAppear(_ animated: Bool) {
        addMapToView()
    }

    @IBAction func showitemView(_ sender: UIButton) {
        if selectMarker != nil {
        isHiden()
        }
    }
    fileprivate func addMapToView() {
        addMarker()
        let camera = GMSCameraPosition.camera(withLatitude: 35.1655379384343, longitude: 33.3601695857942, zoom: 8)
        mapView.isMyLocationEnabled = true
        mapView.camera = camera
    }

    func addMarker() {
        guard self.branch != nil else {
            return
        }
        for item in branch! {
            let position = item.position()
            let marker = GMSMarker(position: position)
            marker.icon = UIImage(named: "pin_passive_icon")
            marker.title = item.title
            marker.snippet = item.address
            marker.map = mapView
        }
    }
    func addInfoLabel() -> String {
        guard selectMarker?.icon == UIImage(named: "pin_active_icon")else {return ""}
        guard self.branch != nil else {return ""}
        var infoString = ""
        for branch in self.branch! where branch.title == selectMarker?.title {
                infoString = """
\(branch.address)
\(branch.postalCode)
T: \(branch.phone)
F: \(branch.fax)
E: \(branch.email)
"""
            return infoString
        }
        return ""
    }
    func drawPath(from polyStr: String) {
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.map = mapView
    }
    func isHiden() {
        if isHide {
            UIView.animate(withDuration: 0.5) {
                self.itemView.frame.origin.y -= 140
            }
            self.itemView.transform = self.itemView.transform.translatedBy( x: 0.0, y: -140.0  )
            isHide = false
            hideButton.setBackgroundImage(UIImage(named: "arrow_down_icon"), for: .normal)
        } else {
            UIView.animate(withDuration: 0.5) {
                self.itemView.frame.origin.y += 140
            }
            self.itemView.transform = self.itemView.transform.translatedBy( x: 0.0, y: 140.0  )
            isHide = true
            hideButton.setBackgroundImage(UIImage(named: "arrow_up_icon"), for: .normal)
        }
    }
}

extension BranchesViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        itemView.isHidden = false
        titleLabel.text = marker.title
        selectMarker?.icon = UIImage(named: "pin_passive_icon")
        marker.icon = UIImage(named: "pin_active_icon")
        if(isHide) == true {
            isHiden()
        }
        selectMarker = marker
        infoLabel.text = addInfoLabel()
        return true
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        selectMarker?.icon = UIImage(named: "pin_passive_icon")
         if(isHide) == false {
               isHiden()
        }
    }
}
