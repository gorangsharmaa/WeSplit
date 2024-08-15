
//  ContentView.swift
//  WeSplit

//  Created by gorang sharma on 29/4/2024.

// opt cmd p - refresh the preview


import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused : Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalAmount : Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = (checkAmount/100 * tipSelection)
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var totalPerPerson : Double {
        let peopleCount = Double(numberOfPeople+2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = (checkAmount/100 * tipSelection)
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack{ // for .navigationLink we need Navigation Stack
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
                    .pickerStyle(.navigationLink) // to create a separate view
                    
                }
                
                Section(header : Text("Tip percentage")) {
                    Picker("Tip Percentage", selection: $tipPercentage){
//                        ForEach(tipPercentages, id: \.self) {
//                            Text($0, format: .percent)
//                        
//                        }
                        ForEach(0..<101){
                            Text("\($0)%")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section(header : Text("Total Amount")) {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section(header: Text("Amount per person")) {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit") // always write it inside NStack with Form
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            
            
        }
    }
}

#Preview {
    ContentView()
}
