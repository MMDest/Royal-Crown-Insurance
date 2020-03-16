//
//  BranchesViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/15/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit
import GoogleMaps

class BranchesViewController: CustomNavigationBarVC {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    var selectMarker:GMSMarker?
    var branch :[Branch]?
    var isHide = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        urlRequest()
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = "Branches"
        self.itemView.transform = self.itemView.transform.translatedBy( x: 0.0, y: 140.0)
        
        addMapToView()
    }
    @IBAction func findDirection(_ sender: UIButton) {
        addMapToView()
//        getRouteSteps(from: branch![1].position(), to: branch![0].position())
    }
    
    @IBAction func showitemView(_ sender: UIButton) {
        if(selectMarker != nil){
        isHiden()
        }
    }
    
    fileprivate func addMapToView() {
        addMarker()
        let camera = GMSCameraPosition.camera(withLatitude: 35.1655379384343, longitude: 33.3601695857942, zoom: 8)
        mapView.isMyLocationEnabled = true
        mapView.camera = camera
    }
    
    func urlRequest() {
        let urlString = "http://31.131.21.105:82/api/v1/branches"
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {print("111")
                return}
            guard error == nil else {print("112")
                return}
            do{
                let json = try JSONDecoder().decode([Branch].self, from: data)
                self.branch = json
                
            }catch let error{
                print(error)
            }
        }.resume()
    }
    
    func addMarker() {
        guard self.branch != nil else {
            return
        }
        for item in branch!{
            let position = item.position()
            let marker = GMSMarker(position: position)
            marker.icon = UIImage(named: "pin_passive_icon")
            marker.title = item.title
            marker.snippet = item.address
            marker.map = mapView
        }
    }
    
    func getRouteSteps(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {

        let session = URLSession.shared

        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving&key=AIzaSyBHsxb2VlTDX1dAJQ-X6rUPbK94nZJsAvc")!

        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] else {
                print("error in JSONSerialization")
                return
            }
//            print("\n\n\(jsonResult)\n\n")
            guard let routes = jsonResult["routes"] as? [Any] else {
                return
            }
            guard let route = routes[0] as? [String: Any] else {
                return
            }
            guard let legs = route["legs"] as? [Any] else {
                return
            }
            guard let leg = legs[0] as? [String: Any] else {
                return
            }
            guard let steps = leg["steps"] as? [Any] else {
                return
            }
              for item in steps {
                guard let step = item as? [String: Any] else {
                    return
                }
                guard let polyline = step["polyline"] as? [String: Any] else {
                    return
                }
                guard let polyLineString = polyline["points"] as? String else {
                    return
                }
                //Call this method to draw path on map
                DispatchQueue.main.async {
                    self.drawPath(from: polyLineString)
                }
            }
        })
        task.resume()
    }

    func addInfoLabel() -> String{
        guard selectMarker?.icon == UIImage(named: "pin_active_icon")else {return ""}
        guard self.branch != nil else {return ""}
        var infoString = ""
        for branch in self.branch!{
            if branch.title == selectMarker?.title{
                infoString = """
\(branch.address)
\(branch.postal_code)
T: \(branch.phone)
F: \(branch.fax)
E: \(branch.email)
"""
            return infoString
            }
        }
        return ""
    }
    func drawPath(from polyStr: String){
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.map = mapView // Google MapView
    }
    func isHiden() {
        if(isHide){
            UIView.animate(withDuration: 0.5){
                self.itemView.frame.origin.y = self.itemView.frame.origin.y - 140
            }
            self.itemView.transform = self.itemView.transform.translatedBy( x: 0.0, y: -140.0  )
            isHide = false
            hideButton.setBackgroundImage(UIImage(named: "arrow_down_icon"), for: .normal)
        }else{
            UIView.animate(withDuration: 0.5){
                self.itemView.frame.origin.y = self.itemView.frame.origin.y + 140
            }
            self.itemView.transform = self.itemView.transform.translatedBy( x: 0.0, y: 140.0  )
            isHide = true
            hideButton.setBackgroundImage(UIImage(named: "arrow_up_icon"), for: .normal)
        }
    }
}

extension BranchesViewController:GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        titleLabel.text = marker.title
        selectMarker?.icon = UIImage(named: "pin_passive_icon")
        marker.icon = UIImage(named: "pin_active_icon")
        if(isHide) == true{
            isHiden()
        }
        selectMarker = marker
        infoLabel.text = addInfoLabel()
        return true
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        selectMarker?.icon = UIImage(named: "pin_passive_icon")
         if(isHide) == false{
               isHiden()
        }
    }
}
