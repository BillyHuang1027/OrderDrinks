//
//  ListTableViewCell.swift
//  OrderDrinks
//
//  Created by 黃昌齊 on 2021/5/29.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var orderNameLabel: UILabel!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var sweetnessLabel: UILabel!
    @IBOutlet weak var toppingsLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var drinkPriceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
