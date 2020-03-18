//
//  WhatToDoIfViewController.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/14/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit
import SVProgressHUD

class WhatToDoIfViewController: CustomNavigationBarVC {
    @IBOutlet weak var tableView: UITableView!
    let networkManager = NetworkManager()
    var instructins: [Instruction] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        request()
        sleep(1)
        tableView.reloadData()
        tableView.rowHeight = tableView.frame.height / 8
    }
    fileprivate func request() {
        SVProgressHUD.show()
        networkManager.getInstructions { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let value) :
                self.instructins = value
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
}
extension WhatToDoIfViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        instructins.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
        cell.textLabel?.text = instructins[indexPath.row].instructionsTitle
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDetailsVC" else {return}
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectRow = instructins[indexPath.row]
            let dvc = segue.destination as? InstructionsViewController
            dvc?.isSecondTitle = selectRow.isTabs
            dvc?.firstTitle = selectRow.firstTabTitle
            dvc?.secondTitle = selectRow.secondTabTitle
            dvc?.firstText = """
            <span style="font-size: 36pt; color: #302B80;">\(selectRow.firstTabContent)</span>
            """
            dvc?.secondText = """
            <span style="font-size: 36pt; color: #302B80;">\(selectRow.secondTabContent)</span>
            """
            dvc?.instructionText = selectRow.instructionsTitle
        }
    }
}
