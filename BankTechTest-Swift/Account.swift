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
        var amount: Double
        
        enum OfType {
            case deposit, withdrawal
        }
        
        var type: OfType
    }
    
    private var transactions: [Transaction] = []
    
    var statement: String {
        let header = "date || credit || debit || balance\n"
        var balance = 0.0
        var transactionStrings: [String] = []
        
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
                transactionStrings.append("\(transactionDate) || \(transactionAmount) || || \(balanceAmount)")
            case .withdrawal:
                balance -= transaction.amount
                let balanceAmount = String(format: "%.2f", balance)
                transactionStrings.append("\(transactionDate) || || \(transactionAmount) || \(balanceAmount)")
            }
        }
        
        return header + transactionStrings.reversed().joined(separator: "\n")
    }
    
    func add(_ type: Transaction.OfType, of amount: Double) {
        switch type {
        case .deposit:
            transactions.append(Transaction(date: Date(), amount: amount, type: .deposit))
        case .withdrawal:
            transactions.append(Transaction(date: Date(), amount: amount, type: .withdrawal))
        }
    }
}
