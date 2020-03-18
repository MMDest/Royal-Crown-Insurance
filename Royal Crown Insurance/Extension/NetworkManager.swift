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
    enum MyError: Error {
        case network
    }
    func getAboutUs(key: String,
                    aboutUrl: String,
                    result: @escaping (Result<String, Error>) -> Void) {
        AF.request("\(NetworkManager.url)\(aboutUrl)").responseJSON { responce in
            switch responce.result {
                case .failure(let error):
                    do {
                    result(.failure(error))
                }
                case .success(let value):
                    do {
                        guard let json = value as? [String: Any] else { return }
                        
                        guard let text = json["\(key)"] as? String else { return }
                        result(.success("""
<span style="font-size: 36pt; color: #302B80;">\(text)</span>
"""))
                }
                
            }
        }
    }
    func getBranch(result: @escaping (Result<[Branch], Error>) -> Void) {
        guard let url = URL(string: "\(NetworkManager.url)/api/v1/branches") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
        guard let data = data else {
            result(.failure(MyError.network))
            return
        }
        guard error == nil else {
            result(.failure(MyError.network))
            return
        }
        do {
            let json = try JSONDecoder().decode([Branch].self, from: data)
            result(.success(json))
        } catch let error {
            result(.failure(error))
            }
        }.resume()
    }
    func getServices(
                     aboutUrl: String,
                     result: @escaping (Result<[Services], Error>) -> Void){
        guard let url = URL(string: "\(NetworkManager.url)/api/v1/services?per_page=14&service_type=\(aboutUrl)&sort_column=title&") else {
            return
        }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print("not data")
                result(.failure(MyError.network))
             return
         }
            print(data)
            guard error == nil else {
                print("Error")
             result(.failure(MyError.network))
             return
         }
            do {
                let json = try JSONDecoder().decode([Services].self, from: data)
             result(.success(json))
            } catch let error {
                print("ErrorJSon")
             result(.failure(error))
            }
        }.resume()
    }
    func getInstructions (result: @escaping (Result<[Instruction], Error>) -> Void) {
        guard let url = URL(string: "\(NetworkManager.url)/api/v1/accident_instructions?sort_column=title&sort_type=asc&") else {
                   return
               }
               print(url)
               URLSession.shared.dataTask(with: url) { (data, _, error) in
                   guard let data = data else {
                       print("not data")
                       result(.failure(MyError.network))
                    return
                }
                   print(data)
                   guard error == nil else {
                       print("Error")
                    result(.failure(MyError.network))
                    return
                }
                   do {
                       let json = try JSONDecoder().decode([Instruction].self, from: data)
                    result(.success(json))
                   } catch let error {
                       print("ErrorJSon")
                    result(.failure(error))
                   }
               }.resume()
    }
}
