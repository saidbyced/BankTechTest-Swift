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
    
    var statement: [String] {
        var balance = Float(0)
        var statement: [String] = []
        
        for transaction in transactions {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_GB")
            dateFormatter.setLocalizedDateFormatFromTemplate("yyyyMMdd")
            let transactionDate = dateFormatter.string(from: transaction.date)
            let transactionAmount = String(format: "%.2f", transaction.amount)
            
            switch transaction.type {
            case .deposit:
                balance += transaction.amount
                let balanceAmount = String(format: "%.2f", balance)
                statement.append("\(transactionDate) || \(transactionAmount) || || \(balanceAmount)")
            case .withdrawal:
                balance -= transaction.amount
                let balanceAmount = String(format: "%.2f", balance)
                statement.append("\(transactionDate) || || \(transactionAmount) || \(balanceAmount)")
            default:
                let balanceAmount = String(format: "%.2f", balance)
                statement.append("\(transactionDate) || || || \(balanceAmount)")
            }
        }
        
        return statement
    }
}
