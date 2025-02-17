//
//  ContentView.swift
//  WeSplit
//
//  Created by TheLyte on 2/17/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    let tipPercentages = 0..<101

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    
                    }.pickerStyle(.navigationLink)
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Total checked amount") {
                    Text(totalCheckedAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                HStack {
                    if amountIsFocused {
                        HStack {
                            Button("Done") {
                                amountIsFocused = false
                            }
                        
                        }
                        
                    }
                    Image(systemName: "house")
                }
                
            }
    
        }
        
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var totalCheckedAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return tipSelection + tipValue
    }
}

#Preview {
    ContentView()
}
