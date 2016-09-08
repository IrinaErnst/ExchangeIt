//
//  FixerDataStore.swift
//  ExchangeIt
//
//  Created by Irina Kalashnikova on 8/25/16.
//  Copyright © 2016 Irina Ernst. All rights reserved.
//

import Foundation

enum RatesResult {
    case Success(FixerRateExchange)
    case Failure(ErrorType)
}

enum RatesError {
    case RatesCreationError
}


class FixerDataStore {
    
    static let sharedInstance = FixerDataStore()
    
    var rates = [FixerRateExchange]()
    
//    func getRateWithCompletion(rate:FixerRateExchange, completion: () -> () ){
//        
//        FixerAPIClient.getRateWithCompletion { (ratesDict) in
//            self.rates.removeAll()
//
//            let rate = FixerRateExchange(dictionary: ratesDict)
//            print("RATE BASE: %@", rate.base)
//            print("RATE DATE: %@", rate.current_date)
//            print("RATE DATE: %@", rate.rates)
//            self.rates.append(rate)
//            
//            if self.rates.count > 0 {
//                completion()
//            }
//        }
//    }
//    
    
    
    
    func getRateWithCompletion( completion: () -> () ){
        
        FixerAPIClient.getRateWithCompletion { (ratesDict) in
            self.rates.removeAll()
            
            let rate = FixerRateExchange(dictionary: ratesDict)
            print("RATE BASE: %@", rate.base)
            print("RATE DATE: %@", rate.current_date)
            print("RATE DATE: %@", rate.rates)
            self.rates.append(rate)
            
            if self.rates.count > 0 {
                completion()
            }
        }
    }
}

