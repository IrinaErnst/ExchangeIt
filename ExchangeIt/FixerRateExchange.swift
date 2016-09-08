//
//  FixerRateExchange.swift
//  ExchangeIt
//
//  Created by Irina Kalashnikova on 8/25/16.
//  Copyright © 2016 Irina Ernst. All rights reserved.
//

import Foundation

class FixerRateExchange {
    
    var base: String!
    var current_date: String!
    var rates: NSDictionary!
    
    init(dictionary: NSDictionary){
        guard let
            currency1 = dictionary["base"] as? String,
            date = dictionary["date"] as? String,
            ratesDict = dictionary["rates"] as? NSDictionary
            else { fatalError("Error creating instance of FixerRareExchange")}
        
        base = currency1
        current_date = date
        rates = ratesDict
    }
    
    init(base: String, current_date: String, rates: NSDictionary){
        self.base = base
        self.current_date = current_date
        self.rates = rates
    }
}
