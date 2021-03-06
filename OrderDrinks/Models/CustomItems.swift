//
//  CustomItems.swift
//  OrderDrinks
//
//  Created by 黃昌齊 on 2021/5/26.
//

import Foundation

enum Temperature: String, CaseIterable {
    case regularIce = "正常冰"
    case lessIce = "少冰"
    case easyIce = "微冰"
    case iceFree = "去冰"
    case warm = "溫"
    case hot = "熱"
}

enum Sweetness: String, CaseIterable {
    case sugarFree = "無糖"
    case quarterSugar = "微糖"
    case halfSugar = "半糖"
    case lessSugar = "少糖"
    case regularSugar = "全糖"
}

enum Size: String, CaseIterable {
    case large = "中杯"
    case medium = "大杯"
}

enum Toppings: String, CaseIterable {
    case none = "無"
    case extraBubble = "白玉珍珠"
    case extraFruitJelly = "百香蒟蒻凍"
}
