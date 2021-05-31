//
//  Order.swift
//  OrderDrinks
//
//  Created by 黃昌齊 on 2021/5/31.
//

import Foundation

struct Order: Codable {
    var orders: [OrderDetail.Field]
    
    init(orders: [OrderDetail.Field] = []) {
        self.orders = orders
    }
}
