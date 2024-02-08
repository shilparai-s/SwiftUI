//
//  ContentView.swift
//  WeSplit
//
//  Created by Shilpa Seetharam on 07/08/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPerson = 0
    @State private var tipPercentage = 20
    var tipsPercentage = [0, 10, 15, 20, 25]
    @FocusState private var amountFocused: Bool
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPerson + 2)
        let tipsSelection = Double(tipPercentage)
        let tipValue = checkAmount * (tipsSelection / 100)
        let finalAmount = checkAmount + tipValue
        return (finalAmount / peopleCount)
    }
    
    var grandTotal: Double {
        let tipsSelection = Double(tipPercentage)
        let tipValue = checkAmount * (tipsSelection / 100)
        let finalAmount = checkAmount + tipValue
        return finalAmount
    }

    
    var body: some View {
        NavigationView(content: {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountFocused)
                        .toolbar(content: {
                            ToolbarItemGroup(placement: .keyboard, content: {
                                Spacer()
                                Button("Done", action: {
                                    amountFocused = false
                                })
                            })
                        })
                    Picker("Number of People", selection: $numberOfPerson, content: {
                        ForEach(2..<100, content: {
                            Text("\($0) People")
                        })
                    })
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage, content: {
                        ForEach(tipsPercentage, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }).pickerStyle(.segmented)
                }header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .black)
                }header: {
                    Text("Grand Total")
                }

                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }header: {
                    Text("Amount per person")
                }

            }
            .navigationTitle("We Split")
        })
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
