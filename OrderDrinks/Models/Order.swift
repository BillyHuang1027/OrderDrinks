//
//  Order.swift
//  OrderDrinks
//
//  Created by 黃昌齊 on 2021/5/31.
//

import Foundation

struct Order: Codable {
    var orders: [OrderDetail.Record]
    
    init(orders: [OrderDetail.Record] = []) {
        self.orders = orders
    }
}
