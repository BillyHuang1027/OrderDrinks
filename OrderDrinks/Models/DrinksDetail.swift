//
//  DrinksDetail.swift
//  OrderDrinks
//
//  Created by 黃昌齊 on 2021/5/19.
//

import Foundation

struct DrinksData: Codable {
    let records: [Record]
}

struct Record: Codable {
    let id: String
    let fields: Field
}

struct Field: Codable {
    let name: String
    let image: [Image]
    let medium: Int
    let large: Int?
    let description: String
}

struct Image: Codable {
    let url: URL
}

