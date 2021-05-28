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
    //抓資料
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
}
