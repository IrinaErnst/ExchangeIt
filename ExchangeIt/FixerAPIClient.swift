//
//  FixerAPIClient.swift
//  ExchangeIt
//
//  Created by Irina Kalashnikova on 8/25/16.
//  Copyright © 2016 Irina Ernst. All rights reserved.
//
import UIKit

enum FixerRatesResult {
    case Success([FixerRateExchange])
    case Failure(ErrorType)
}

enum FixerError: ErrorType {
    case InvalidJSONData
}

class FixerAPIClient {
    
    class func getRateWithCompletion(completion: (NSDictionary) -> () ) {
        
        let urlString = "https://api.fixer.io/latest?base=USD"
        let url = NSURL(string: urlString)
        let session = NSURLSession.sharedSession()
        guard let potentialURL = url else {
            assertionFailure("Invalid URL");
            return
        }
        let task = session.dataTaskWithURL(potentialURL) {
            (data, response, error) in
            guard let data = data else {
                assertionFailure("Unable to get data \(error?.localizedDescription)");
                return
            }
            if let jsonResult : AnyObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []) {

                if let responseDict = jsonResult as? NSDictionary {
                    print("RESULT DICT: %@", responseDict)
                    completion(responseDict)
                }
            }
        }
        task.resume()
        
    }
    
}

