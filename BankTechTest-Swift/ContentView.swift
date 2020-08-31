//
//  ContentView.swift
//  BankTechTest-Swift
//
//  Created by Chris Eadie on 31/08/2020.
//  Copyright © 2020 Chris Eadie Designs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var account = Account()
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Button(
                        action: { print("deposit made") },
                        label: { Text("Deposit (+)") }
                    )
                        .padding(5)
                }
                Button(
                    action: { print("withdrawal made") },
                    label: { Text("Withdraw (-)") }
                )
                    .padding(5)
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
