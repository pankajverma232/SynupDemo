//
//  Constants.swift
//  SynupDemo
//
//  Created by Pankaj Verma on 24/08/19.
//  Copyright © 2019 Pankaj Verma. All rights reserved.
//

import Foundation

enum Constants{
    
    
    static let varientsBaseUrl = "https://api.myjson.com/"
    enum urls{
        static let varients = varientsBaseUrl+"bins/19u0sf"
    }
    

    enum Strings{
        
        enum HomeScene {
            static let inStock = "in stock"
            static let outOfStock = "out of stock"
            static let applyFilter = "Apply Filter"
            static let title = "Home"
            static let noResponse = "No response"
        }
        
        enum NetworkError{
            static let client = "Client Error"
            static let server = "Server error"
            static let mimeType = "Mime type error"
            static let noData = "No data"
            static let invalidUrl = "invalid url"
        }
    }
    
}
