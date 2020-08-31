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
    @State private var showingStatement = false
    @State private var statementButtonLabel = "Print Statement"
    
    var account = Account()
    
    func add(_ type: Account.Transaction.OfType) {
        guard let amount = Float(transactionAmount) else {
            self.transactionAmount = ""
            return
        }
        
        if type == .deposit {
            account.deposit(amount)
        } else if type == .withdrawal {
            account.withdraw(amount)
        } else {
            print("Error - no such transaction type")
        }
        
        self.transactionAmount = ""
    }
    
    func printStatement() {
        let transactionList = account.transactions
        let header = "date || credit || debit || balance\n"
        var statementArray: [String] = []
        var balance = Float(0)
        
        for transaction in transactionList {
            let transactionAmount = String(format: "%.2f", transaction.amount)
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_GB")
            dateFormatter.setLocalizedDateFormatFromTemplate("yyyyMMdd")
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
        statementButtonLabel = "Reprint Statement"
        self.showingStatement = true
    }
    
    var body: some View {
        VStack {
            VStack {
                TextField("Transaction Amount", text: $transactionAmount)
                    .multilineTextAlignment(.center)
                    .frame(width: 200)
                HStack {
                    Button(
                        action: {
                            self.add(.deposit)
                        },
                        label: {
                            Text("Deposit (+)")
                        }
                    )
                        .disabled(transactionAmount == "")
                        .padding(5)
                    Button(
                        action: {
                            self.add(.withdrawal)
                        },
                        label: {
                            Text("Withdraw (-)")
                            
                        }
                    )
                        .disabled(transactionAmount == "")
                        .padding(5)
                }
            }
            Button(
                action: {
                    self.printStatement()
                },
                label: {
                    Text(statementButtonLabel)
                }
            )
                .padding(5)
            Group {
                if showingStatement == false {
                    Text(statement)
                        .hidden()
                } else {
                    Button(
                        action: {
                            self.showingStatement = false
                        },
                        label: {
                            Text("Hide Statement")
                        }
                    )
                        .padding(5)
                    Text(statement)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
