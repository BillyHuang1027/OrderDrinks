//
//  MenuController.swift
//  OrderDrinks
//
//  Created by 黃昌齊 on 2021/5/21.
//

import Foundation
import UIKit

public let apiKey = "keyx9HTNFU3b7AMpV"
class MenuController {
    static let shared = MenuController()
    static let orderUpdateNotification = Notification.Name("MenuController.orderUpdate")
    
    var order = Order() {
        didSet {
            NotificationCenter.default.post(name: MenuController.orderUpdateNotification, object: nil)
        }
    }
    
    //抓Menu資料
    func fetchData(urlStr: String, completion: @escaping (Result<[Record], Error>) -> Void) {
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let menuResponse = try decoder.decode(DrinksData.self, from: data)
                    completion(.success(menuResponse.records))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    //抓圖片
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
               let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
    //上傳資料到airtable
    func uploadData(urlStr: String, data: OrderDetail) {
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(data)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let content = String(data: data, encoding: .utf8)
                    print(content)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func fetchOrderData(urlStr: String, completion: @escaping (Result<[OrderList.Record], Error>) -> Void) {
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(OrderList.self, from: data)
                    completion(.success(response.records))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func deleteOrderData(urlStr: String) {
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse, error == nil {
                print("Delete success")
                print(response.statusCode)
            } else {
                print(error)
            }
        } .resume()
    }
}

