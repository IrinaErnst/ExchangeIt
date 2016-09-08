//
//  TableVC.swift
//  ExchangeIt
//
//  Created by Irina Kalashnikova on 8/31/16.
//  Copyright © 2016 Irina Ernst. All rights reserved.
//

import UIKit

class TableVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView = UITableView()
    let data = ["🇺🇸 USD", "💶 EUR", "🇦🇺 AUD", "🇧🇬 BGN", "🇧🇷 BRL", "🇨🇦 CAD", "🇨🇭 CHF", "🇨🇳 CNY", "🇨🇿 CZK", "🇩🇰 DKK", "🇬🇧 GBP", "🇭🇰 HKD", "🇭🇷 HRK", "🇭🇺 HUF", "🇮🇩 IDR", "🇮🇱 ILS", "🇮🇳 INR", "🇯🇵 JPY", "🇰🇷 KRW", "🇲🇽 MXN", "🇲🇾 MYR", "🇳🇴 NOK", "🇳🇿 NZD", "🇵🇭 PHP", "🇵🇱 PLN", "🇷🇴 RON", "🇷🇺 RUB", "🇸🇪 SEK", "🇸🇬 SGD", "🇹🇭 THB", "🇹🇷 TRY", "🇿🇦 ZAR"]
    let dataSym:[String:String] = [ "🇺🇸 USD" : "US$",
                                    "💶 EUR" : "€",
                                    "🇦🇺 AUD" : "A$",
                                    "🇧🇬 BGN" : "lion",
                                    "🇧🇷 BRL" : "R$",
                                    "🇨🇦 CAD" : "C$",
                                    "🇨🇭 CHF" : "Fr",
                                    "🇨🇳 CNY" : "圆 ¥",
                                    "🇨🇿 CZK" : "Kč",
                                    "🇩🇰 DKK" : "kr",
                                    "🇬🇧 GBP" : "£",
                                    "🇭🇰 HKD" : "HK$",
                                    "🇭🇷 HRK" : "kn",
                                    "🇭🇺 HUF" : "Ft",
                                    "🇮🇩 IDR" : "Rp",
                                    "🇮🇱 ILS" : "₪",
                                    "🇮🇳 INR" : "₹",
                                    "🇯🇵 JPY" : "円 ¥",
                                    "🇰🇷 KRW" : "₩",
                                    "🇲🇽 MXN" :"M$",
                                    "🇲🇾 MYR" : "RM",
                                    "🇳🇴 NOK" : "kr",
                                    "🇳🇿 NZD" : "NZ$",
                                    "🇵🇭 PHP" : "₱",
                                    "🇵🇱 PLN" : "zł",
                                    "🇷🇴 RON" : "lei",
                                    "🇷🇺 RUB" : "руб",
                                    "🇸🇪 SEK" : "kr",
                                    "🇸🇬 SGD" : "S$",
                                    "🇹🇭 THB" : "฿",
                                    "🇹🇷 TRY" : "Kr",
                                    "🇿🇦 ZAR" : "R" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let currency = self.data[indexPath.row]
        cell.textLabel!.text = currency
        cell.detailTextLabel!.text = self.dataSym[currency]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print (self.data[indexPath.row])
    }
    
}
