//
//  ContentView.swift
//  BankTechTest-Swift
//
//  Created by Chris Eadie on 31/08/2020.
//  Copyright © 2020 Chris Eadie Designs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var transactionAmount = ""
    @State private var statement = ""
    
    var account = Account()
    
    func add(_ type: Account.Transaction.OfType) {
        guard let amount = Float(transactionAmount) else { return }
        
        if type == .deposit {
            account.deposit(amount)
        } else if type == .withdrawal {
            account.withdraw(amount)
        }
    }
    
    func printStatement() {
        let transactionList = account.transactions
        var statementArray: [String] = []
        let header = "date || credit || debit || balance\n"
        var balance = Float(0)
        
        for transaction in transactionList {
            let transactionAmount = String(format: "%.2f", transaction.amount)
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_GB")
            dateFormatter.setLocalizedDateFormatFromTemplate("yyMMdd")
            let transactionDate = dateFormatter.string(from: transaction.date)
            
            if transaction.type == .deposit {
                balance += transaction.amount
                let balanceAmount = String(format: "%.2f", balance)
                statementArray.append("\(transactionDate) || \(transactionAmount) || || \(balanceAmount)")
            } else if transaction.type == .withdrawal {
                balance -= transaction.amount
                let balanceAmount = String(format: "%.2f", balance)
                statementArray.append("\(transactionDate) || || \(transactionAmount) || \(balanceAmount)")
            } else {
                print("Error - no such transaction type")
            }
        }
        
        statement = header + statementArray.reversed().joined(separator: "\n")
    }
    
    var body: some View {
        VStack {
            VStack {
                TextField("Transaction Amount", text: $transactionAmount)
                    .multilineTextAlignment(.center)
                    .frame(width: 200)
                HStack {
                    Button(
                        action: { self.add(.deposit) },
                        label: { Text("Deposit (+)") }
                    )
                        .padding(5)
                    Button(
                        action: { self.add(.withdrawal) },
                        label: { Text("Withdraw (-)") }
                    )
                        .padding(5)
                }
            }
            Button(
                action: { self.printStatement() },
                label: { Text("Print Statement") }
            )
                .padding(5)
            Text(statement)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
