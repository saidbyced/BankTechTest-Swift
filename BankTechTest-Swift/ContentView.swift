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
    @State private var printableStatement = ""
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
        let header = "date || credit || debit || balance\n"
        
        printableStatement = header + account.statement.reversed().joined(separator: "\n")
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
                    Text(printableStatement)
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
                    Text(printableStatement)
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
