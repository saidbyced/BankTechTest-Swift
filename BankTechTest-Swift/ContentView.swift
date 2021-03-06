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
    
    func printStatement() {
        printableStatement = account.statement
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
                            self.account.add(.deposit, of: Double(self.transactionAmount)!)
                            self.transactionAmount = ""
                        },
                        label: {
                            Text("Deposit (+)")
                        }
                    )
                        .disabled(transactionAmount == "")
                        .padding(5)
                    Button(
                        action: {
                            self.account.add(.withdrawal, of: Double(self.transactionAmount)!)
                            self.transactionAmount = ""
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
                if showingStatement == true {
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
