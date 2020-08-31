//
//  Account.swift
//  BankTechTest-Swift
//
//  Created by Chris Eadie on 31/08/2020.
//  Copyright © 2020 Chris Eadie Designs. All rights reserved.
//

import Foundation

class Account {
    var transactions: [Transaction] = []
}

struct Transaction {
    var date: Date
    var amount: Float
    
    enum TransationType {
        case Withdrawl, Deposit
    }
    
    var type: TransationType
}
