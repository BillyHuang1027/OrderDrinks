//
//  ListTableViewController.swift
//  OrderDrinks
//
//  Created by 黃昌齊 on 2021/5/29.
//

import UIKit

class OrderListTableViewController: UITableViewController {
    
    var orderData = [OrderDetail.Record]()

    override func viewDidLoad() {
        super.viewDidLoad()
  
        NotificationCenter.default.addObserver(tableView!, selector: #selector(UITableView.reloadData), name: MenuController.orderUpdateNotification, object: nil)
    }
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return MenuController.shared.order.orders.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderListTableViewCell", for: indexPath) as! OrderListTableViewCell
        let orderDetail = MenuController.shared.order.orders[indexPath.section]
        MenuController.shared.fetchImage(url: orderDetail.image) { (Image) in
            guard let image = Image else { return }
            DispatchQueue.main.async {
                cell.drinkImageView.image = image
            }
        }
        cell.orderNameLabel.text = orderDetail.name
        cell.drinkNameLabel.text = orderDetail.drink
        cell.tempLabel.text = orderDetail.temperature
        cell.sweetnessLabel.text = orderDetail.sweetness
        cell.countLabel.text = "\(orderDetail.quantity)杯"
        cell.drinkPriceLabel.text = String(orderDetail.price)
        if orderDetail.toppings == "無" {
            cell.toppingsLabel.text = ""
        } else {
            cell.toppingsLabel.text = "+\(orderDetail.toppings)"
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
