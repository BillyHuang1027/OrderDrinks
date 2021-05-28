//
//  OrderTableViewController.swift
//  OrderDrinks
//
//  Created by 黃昌齊 on 2021/5/24.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    var menuDatas: Record!
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkDescription: UILabel!
    @IBOutlet weak var orderersNameTextField: UITextField!
    @IBOutlet weak var drinksTemperatureTextField: UITextField!
    @IBOutlet weak var drinkSweetnessTextField: UITextField!
    @IBOutlet weak var drinkSizeTextField: UITextField!
    @IBOutlet weak var toppingsTextField: UITextField!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    let pickerView = UIPickerView()
    var temp = String()
    var sweetness = String()
    var size = String()
    var toppings = String()
    var quantity = 1
    var price = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drinkNameLabel.text = menuDatas.fields.name
        drinkDescription.text = menuDatas.fields.description
        //抓圖
        let imageUrl = menuDatas.fields.image[0].url
        MenuController.shared.fetchImage(url: imageUrl) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.drinkImage.image = image
            }
        }
        orderersNameTextField.delegate = self
        drinksTemperatureTextField.delegate = self
        drinkSweetnessTextField.delegate = self
        drinkSizeTextField.delegate = self
        toppingsTextField.delegate = self
        tapGesture()
        quantityLabel.text = String(quantity)
        priceLabel.text = String(price)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //增加一個觸控事件
    func tapGesture() {
        let tapGestrue = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGestrue.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGestrue)
    }
    //按空白處會隱藏鍵盤或pickerView
    @objc func hideKeyboard() {
        tableView.endEditing(true)
    }
    //設定pickerview
    func setPickerView(selectedAt sender: UITextField) {
        switch sender {
        case drinksTemperatureTextField:
            pickerView.tag = 0
        case drinkSweetnessTextField:
            pickerView.tag = 1
        case drinkSizeTextField:
            pickerView.tag = 2
        case toppingsTextField:
            pickerView.tag = 3
        default:
            break
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        //設定PickerView的ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .systemBlue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "確認", style: .plain, target: self, action: #selector(done))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancel))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        drinksTemperatureTextField.inputView = pickerView
        drinksTemperatureTextField.inputAccessoryView = toolBar
        drinkSweetnessTextField.inputView = pickerView
        drinkSweetnessTextField.inputAccessoryView = toolBar
        drinkSizeTextField.inputView = pickerView
        if drinkNameLabel.text == "熟成檸果" {
            drinkSizeTextField.text = Size.allCases[0].rawValue
        }
        drinkSizeTextField.inputAccessoryView = toolBar
        toppingsTextField.inputView = pickerView
        toppingsTextField.inputAccessoryView = toolBar
    }
    //確認鍵動作
    @objc func done() {
        switch pickerView.tag {
        case 0:
            drinksTemperatureTextField.text = temp
            if temp.isEmpty == true {
                drinksTemperatureTextField.text = Temperature.allCases[0].rawValue
            }
            drinksTemperatureTextField.resignFirstResponder()
        case 1:
            drinkSweetnessTextField.text = sweetness
            if sweetness.isEmpty == true {
                drinkSweetnessTextField.text = Sweetness.allCases[0].rawValue
            }
            drinkSweetnessTextField.resignFirstResponder()
        case 2:
            drinkSizeTextField.text = size
            if size.isEmpty == true {
                drinkSizeTextField.text = Size.allCases[0].rawValue
                price = menuDatas.fields.medium
                priceLabel.text = String(price)
            }
            drinkSizeTextField.resignFirstResponder()
        default:
            toppingsTextField.text = toppings
            if toppings.isEmpty == true {
                toppingsTextField.text = Toppings.allCases[0].rawValue
            }
            toppingsTextField.resignFirstResponder()
        }
    }
    //取消鍵動作
    @objc func cancel() {
        drinksTemperatureTextField.resignFirstResponder()
        drinkSweetnessTextField.resignFirstResponder()
        drinkSizeTextField.resignFirstResponder()
        toppingsTextField.resignFirstResponder()
    }
    
    @IBAction func minusButton(_ sender: Any) {
        if quantity <= 1 {
            showAlert()
        } else {
            quantity -= 1
            quantityLabel.text = String(quantity)
            priceLabel.text = String(price * quantity)
        }
    }
    
    @IBAction func plusButton(_ sender: Any) {
        quantity += 1
        quantityLabel.text = String(quantity)
        priceLabel.text = String(price * quantity)
    }
    //數量低於1杯跳alert視窗
    func showAlert() {
        let alert = UIAlertController(title: "錯誤數量！", message: "請輸入1杯以上", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    */

    /*override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
