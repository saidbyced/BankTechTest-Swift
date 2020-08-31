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
    
    var account = Account()
    
    func add(_ type: Transaction.OfType) {
        guard let amount = Float(transactionAmount) else { return }
        
        if type == .deposit {
            account.deposit(amount)
        } else if type == .withdrawal {
            account.withdraw(amount)
        }
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
            Text(
                "date || credit || debit || balance\n14/01/2012 || || 500.00 || 2500.00\n13/01/2012 || 2000.00 || || 3000.00\n10/01/2012 || 1000.00 || || 1000.00"
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
