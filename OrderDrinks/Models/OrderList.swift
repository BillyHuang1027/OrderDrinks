//
//  OrderList.swift
//  OrderDrinks
//
//  Created by 黃昌齊 on 2021/6/7.
//

import Foundation

struct OrderList: Codable {
    var records: [Record]
    
    struct Record: Codable {
        var id: String
        var fields: OrderDetail.Field
    }

}
