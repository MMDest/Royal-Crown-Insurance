//
//  ListServicesViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/17/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit
import SVProgressHUD

class ListServicesViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    var typeServices = ""
    var typeRequest: String {
        if typeServices == "BUSINESS"{
            return "business"
        } else {
            return "personal"
        }
    }
    var services: [Services] = []
    var networkManager = NetworkManager()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = typeServices
        navigationItem.titleView = UIImageView(image: UIImage(named: "red_logo_icon"))
    }
    override func viewDidAppear(_ animated: Bool) {
        request()
        sleep(1)
        SVProgressHUD.dismiss()
        tableView.reloadData()
    }
    fileprivate func request() {
        SVProgressHUD.show()
        print(typeRequest)
        networkManager.getServices(aboutUrl: typeRequest) { result in
            switch result {
            case .success(let value) :
                print(value)
                self.services = value
            case .failure(let error) :
                let alert = UIAlertController(title: "Error",
                                              message: "The request timed out",
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
}

extension ListServicesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(services.count)
        return services.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "servicesCell", for: indexPath)
        print(services[indexPath.row].title)
        cell.textLabel?.text = services[indexPath.row].title
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "infoVC" else {return}
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectRow = services[indexPath.row]
            let dvc = segue.destination as? InfoServicesViewController
            dvc?.services = selectRow.title
            dvc?.infoServices = selectRow.description
            dvc?.typeServic = typeServices
            dvc?.urlString = selectRow.website
        }
    }
}
