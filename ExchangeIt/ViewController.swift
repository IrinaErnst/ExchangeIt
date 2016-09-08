//
//  ViewController.swift
//  ExchangeIt
//
//  Created by Irina Kalashnikova on 8/23/16.
//  Copyright © 2016 Irina Ernst. All rights reserved.
//

import UIKit
//import DropDown

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var fromCurrencyButton: UIButton!
    @IBOutlet weak var fromCurrencyTableView: UITableView!
    @IBOutlet weak var toCurrencyButton: UIButton!
    @IBOutlet weak var toCurrencyTableView: UITableView!
    
    @IBOutlet weak var currency1: UILabel!
    @IBOutlet weak var currency2: UILabel!
    @IBOutlet weak var exchangeRate: UILabel!
    @IBOutlet weak var sellerBuyerSegmentControl: UISegmentedControl!
    
    let currencyData: NSArray = ["🇺🇸 USD", "💶 EUR", "🇦🇺 AUD", "🇧🇬 BGN", "🇧🇷 BRL", "🇨🇦 CAD", "🇨🇭 CHF", "🇨🇳 CNY", "🇨🇿 CZK", "🇩🇰 DKK", "🇬🇧 GBP", "🇭🇰 HKD", "🇭🇷 HRK", "🇭🇺 HUF", "🇮🇩 IDR", "🇮🇱 ILS", "🇮🇳 INR", "🇯🇵 JPY", "🇰🇷 KRW", "🇲🇽 MXN", "🇲🇾 MYR", "🇳🇴 NOK", "🇳🇿 NZD", "🇵🇭 PHP", "🇵🇱 PLN", "🇷🇴 RON", "🇷🇺 RUB", "🇸🇪 SEK", "🇸🇬 SGD", "🇹🇭 THB", "🇹🇷 TRY", "🇿🇦 ZAR"]
    let currencyData1: NSArray = ["🇺🇸 USD"]
    let currencyDataDict: [String:String] = ["🇺🇸 USD":"USD", "💶 EUR":"EUR", "🇦🇺 AUD":"AUD", "🇧🇬 BGN":"BGN", "🇧🇷 BRL":"BRL", "🇨🇦 CAD":"CAD", "🇨🇭 CHF":"CHF", "🇨🇳 CNY":"CNY", "🇨🇿 CZK":"CZK", "🇩🇰 DKK":"DKK", "🇬🇧 GBP":"GBP", "🇭🇰 HKD":"HKD", "🇭🇷 HRK":"HRK", "🇭🇺 HUF":"HUF", "🇮🇩 IDR":"IDR", "🇮🇱 ILS":"ILS", "🇮🇳 INR":"INR", "🇯🇵 JPY":"JPY", "🇰🇷 KRW":"KRW", "🇲🇽 MXN":"MXN", "🇲🇾 MYR":"MYR", "🇳🇴 NOK":"NOK", "🇳🇿 NZD":"NZD", "🇵🇭 PHP":"PHP", "🇵🇱 PLN":"PLN", "🇷🇴 RON":"RON", "🇷🇺 RUB":"RUB", "🇸🇪 SEK":"SEK", "🇸🇬 SGD":"SGD", "🇹🇭 THB":"THB", "🇹🇷 TRY":"TRY", "🇿🇦 ZAR":"ZAR"]
    
    let currencySymbol:[String:String] = [ "USD" : "US$",
                                    "EUR" : "€",
                                    "AUD" : "A$",
                                    "BGN" : "lion",
                                    "BRL" : "R$",
                                    "CAD" : "C$",
                                    "CHF" : "Fr",
                                    "CNY" : "圆 ¥",
                                    "CZK" : "Kč",
                                    "DKK" : "kr",
                                    "GBP" : "£",
                                    "HKD" : "HK$",
                                    "HRK" : "kn",
                                    "HUF" : "Ft",
                                    "IDR" : "Rp",
                                    "ILS" : "₪",
                                    "INR" : "₹",
                                    "JPY" : "円 ¥",
                                    "KRW" : "₩",
                                    "MXN" :"M$",
                                    "MYR" : "RM",
                                    "NOK" : "kr",
                                    "NZD" : "NZ$",
                                    "PHP" : "₱",
                                    "PLN" : "zł",
                                    "RON" : "lei",
                                    "RUB" : "руб",
                                    "SEK" : "kr",
                                    "SGD" : "S$",
                                    "THB" : "฿",
                                    "TRY" : "Kr",
                                    "ZAR" : "R" ]
    let exchangeItLogo = UIImage(named: "ExchangeItLogo.png")
    let exchRateLabel:UILabel = UILabel()

    let store = FixerDataStore.sharedInstance
    var fromCurrency:String = "Select"
    var toCurrency:String = "Select"
    var currency: String? = ""
    var rate = FixerRateExchange(base: "USD", current_date: "", rates: NSDictionary())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLogo()
        setCurrencyTables()
        setExRateLabel()
        
        self.currency1.text = self.fromCurrency
        self.currency1.textColor = UIColor.whiteColor()
        self.toCurrencyButton.backgroundColor = UIColor.whiteColor()
        self.toCurrencyButton.layer.cornerRadius = 5
        
        self.currency2.text = self.toCurrency
        self.currency2.textColor = UIColor.whiteColor()
        self.fromCurrencyButton.backgroundColor = UIColor.whiteColor()
        self.fromCurrencyButton.layer.cornerRadius = 5
        
        
        store.getRateWithCompletion() {
            
            NSOperationQueue.mainQueue().addOperationWithBlock({

                let newRate: FixerRateExchange = self.store.rates.first!
                self.rate = newRate
                self.fromCurrency = newRate.base
                self.fromCurrencyButton.setTitle(self.fromCurrency, forState: UIControlState.Normal)
                self.toCurrencyButton.setTitle(self.toCurrency, forState: UIControlState.Normal)
                if let cur = self.currencyDataDict[self.toCurrency]{
                    self.currency = cur
                    if let x = newRate.rates[cur]{
                        print("CURRENCY %@", x)
                        self.exchangeRate.text = x.stringValue
                    }
                }
            })
        }
    }
    
    func setLogo(){
        let exchangeItLogoView = UIImageView(image: self.exchangeItLogo!)
        exchangeItLogoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(exchangeItLogoView)
        
        let horizontalConstraint = exchangeItLogoView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
        let topConstraint = exchangeItLogoView.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 10)
        let widthConstraint = exchangeItLogoView.widthAnchor.constraintEqualToAnchor(nil, constant: 115)
        let heightConstraint = exchangeItLogoView.heightAnchor.constraintEqualToAnchor(nil, constant: 45)
        NSLayoutConstraint.activateConstraints([horizontalConstraint, topConstraint,widthConstraint, heightConstraint])
    }
    
    func setCurrencyTables() {
        let tableViews = [self.fromCurrencyTableView, self.toCurrencyTableView]
        for table in tableViews {
            table.delegate = self
            table.dataSource = self
            if table == self.fromCurrencyTableView {
                table.registerClass(UITableViewCell.self, forCellReuseIdentifier: "FromCurrencyItem")
            }
            if table == self.toCurrencyTableView {
                table.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ToCurrencyItem")
            }
            table.alpha = 0.7
            table.hidden = true
        }
    }
    
    func setExRateLabel(){
        //self.exchRateLabel.text = "Rate Exchange"
        self.exchRateLabel.textColor = UIColor.whiteColor()
        self.exchRateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.exchRateLabel)
        
        let exchRateHorizontalConstraint = self.exchRateLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
        let exchRateTopConstraint = self.exchRateLabel.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 150)
        let exchRateWidthConstraint = self.exchRateLabel.widthAnchor.constraintEqualToAnchor(nil, constant: 250)
        let exchRateHeightConstraint = self.exchRateLabel.heightAnchor.constraintEqualToAnchor(nil, constant: 45)
        NSLayoutConstraint.activateConstraints([exchRateHorizontalConstraint, exchRateTopConstraint, exchRateWidthConstraint, exchRateHeightConstraint])
    
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int?
        if tableView == self.fromCurrencyTableView {
            count = self.currencyData1.count
        }
        if tableView == self.toCurrencyTableView {
            count = self.currencyData.count
        }
        return count!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell?
        
        if tableView == self.fromCurrencyTableView {
            cell = tableView.dequeueReusableCellWithIdentifier("FromCurrencyItem", forIndexPath: indexPath)
            cell!.textLabel!.text = self.currencyData[indexPath.row] as? String
        }
        if tableView == self.toCurrencyTableView {
            cell = tableView.dequeueReusableCellWithIdentifier("ToCurrencyItem", forIndexPath: indexPath)
            cell!.textLabel!.text = self.currencyData[indexPath.row] as? String
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if tableView == self.fromCurrencyTableView {
            self.fromCurrency = self.currencyDataDict[(cell!.textLabel?.text)!]!
            self.fromCurrencyButton.setTitle((cell!.textLabel?.text)!, forState: UIControlState.Normal)
        }
        if tableView == self.toCurrencyTableView {
            self.toCurrency = self.currencyDataDict[(cell!.textLabel?.text)!]!
            self.toCurrencyButton.setTitle((cell!.textLabel?.text)!, forState: UIControlState.Normal)
            print(self.toCurrency)
            if let exRate = self.rate.rates[self.toCurrency] {
                print(exRate)
                let curSymbol:String = currencySymbol[self.toCurrency as String]!
                self.exchRateLabel.text = "Official rate: $1 is " + curSymbol + exRate.stringValue
                print(self.exchRateLabel.text)
            }
        }
        tableView.hidden = true
    }
    
    
    @IBAction func SellerBuyerSegmentControl(sender: UISegmentedControl) {
        switch sellerBuyerSegmentControl.selectedSegmentIndex {
        case 0: print("Seller")
        case 1: print("Buyer")
        default: print("ERROR")
        }
    }

    @IBAction func fromCurrencyButton(sender: AnyObject) {
        if self.fromCurrencyTableView.hidden == true {
            self.fromCurrencyTableView.hidden = false
        } else {
            self.fromCurrencyTableView.hidden = true
        }
    }
    
    @IBAction func toCurrencyButton(sender: AnyObject) {
    
        if self.toCurrencyTableView.hidden == true {
            self.toCurrencyTableView.hidden = false
        } else {
            self.toCurrencyTableView.hidden = true
        }
    }
}

