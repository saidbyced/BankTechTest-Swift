//
//  Account.swift
//  BankTechTest-Swift
//
//  Created by Chris Eadie on 31/08/2020.
//  Copyright © 2020 Chris Eadie Designs. All rights reserved.
//

import Foundation

class Account {
    struct Transaction {
        var date: Date
        var amount: Float
        
        enum OfType {
            case deposit, withdrawal
        }
        
        var type: OfType
    }
    
    var transactions: [Transaction] = []
    
    func deposit(_ amount: Float) {
        transactions.append(Transaction(date: Date(), amount: amount, type: .deposit))
    }
    
    func withdraw(_ amount: Float) {
        transactions.append(Transaction(date: Date(), amount: amount, type: .withdrawal))
    }
}
