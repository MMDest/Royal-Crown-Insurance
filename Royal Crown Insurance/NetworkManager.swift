//
//  NetworkManager.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/17/20.
//  Copyright © 2020 MineDest. All rights reserved.
//
// swiftlint:disable all
import Foundation
import Alamofire

class NetworkManager
{
    static private var url = "http://31.131.21.105:82"
//    let url =  URL(string: "http://31.131.21.105:82/api/v1/about_us")
//    let task = URLSession.shared.dataTask(with: url!) { (data, _, error) in
//            if error != nil {
//                print("Error")
//                let alert = UIAlertController(title: "Error",
//                                              message: "The request tined out",
//                                              preferredStyle: .alert)
//                let okButton  = UIAlertAction(title: "OK", style: .default) { (_) in
//                    self.navigationController?.popViewController(animated: true)
//                }
//                alert.addAction(okButton)
//                self.present(alert, animated: true, completion: nil)
//            } else {
//            if let content = data {
//                do {
//                    let myJson = try JSONSerialization.jsonObject(with: content, options:
//                        JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
//                    let about = myJson["about_us"] as? String
//                    self.aboutUs = """
//                    <span style="font-size: 36pt; color: #302B80;">\(about!)</span>
//                    """
//                    print(self.aboutUs)
//                    return
//                    } catch {
//                }
//            }
//        }
//    }
//    task.resume()
    enum MyError: Error {
        case network
    }
    func getAboutUs(aboutUrl: String, result: (Result<String, Error>) -> Void) {
        AF.request("\(NetworkManager.url)\(aboutUrl)").response { reponce in print(reponce)
        }
        result(.success("Succes"))
        result(.failure(MyError.network))
    }
}
