//
//  AddTransactionForm.swift
//  LedgerIO
//
//  Created by Alex Lazcano on 2024-04-03.
//

import SwiftUI

var mainUser: User = User(id: "3", name: "Alex Main")
var user3 = User(id: "4", name: "Jack")
var friends: [User] = [user1, user2]

enum SplitTypes: String, CaseIterable {
    case fixedAmount = "Fixed Amount"
    case half = "Half"
    //    case percentage = "Percentage"
    
}

struct AddTransactionForm: View {
    @Binding var isShowing: Bool
    @State private var selectedFriendIndex: Int? = nil
    @State private var total: String = ""
    @State private var splitAmount: String = "0.0"
    @State private var description: String = ""
    @State private var split: SplitTypes = .half
    
    let displayNames: [String] = SplitTypes.allCases.map { $0.rawValue }
    
    var body: some View {
        List {
            Text(mainUser.name)
            
            Section(header: Text("Select Friend")) {
                
                Picker("Friend", selection: $selectedFriendIndex) {
                    Text("None Selected").tag(nil as Int?)
                    ForEach(0..<friends.count, id: \.self) { index in
                        Text(friends[index].name).tag(index as Int?)
                    }
                }
            }
            
            if let selectedIndex = selectedFriendIndex {
                Text("Selected Friend: \(friends[selectedIndex].name)")
            } else {
                Text("No friend selected")
            }
            
            Section(header: Text("Total Amount")) {
                TextField("Enter your Total", text: $total)
                    .numbersOnly($total, includeDecimal: true)
                    .onChange(of: total) { _, newValue in
                        switch split {
                        case .half:
                            splitAmount = calcHalfValue(total: total)
                            
                        default:
                            splitAmount = splitAmount
                        }
                    }
            }
            Section(header: Text("Paid by Recipient")) {
                Picker("Division Style", selection: $split) {
                    ForEach(SplitTypes.allCases, id: \.self) { style in
                        Text(style.rawValue).tag(style)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: split)  {
                    
                    if split == .half {
                        splitAmount = calcHalfValue(total: total)
                    }
                }
                
                switch split {
                case .half:
                    Text("50 / 50")
                    
                case .fixedAmount:
                    TextField("Enter your Fixed Amount", text: $splitAmount)
                        .numbersOnly($total, includeDecimal: true)
                    
                    //                case .percentage:
                    //                    TextField("Enter your Percentage Amount", text: $splitAmount)
                    //                        .numbersOnly($total, includeDecimal: false)
                    
                }
                
                HStack {
                    
                    VStack {
                        Text("You")
                            .font(.title3)
                        Text("$\(String(format: "%.2f", Double(splitAmount) ?? 0.0))")
                            .font(.title2)
                    }
                    .bold()
                    .padding(4)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(Color.green.gradient)
                    .cornerRadius(10)

                    
                    Image(systemName: "arrow.forward.square")
                        .font(.title)
                        .foregroundColor(.black)
                  
                    
                    VStack {
                        Text("Friend")
                            .font(.title3)
                            
                        Text("$\(String(format: "%.2f", ((Double(total) ?? 0.0) - (Double(splitAmount) ?? 0.0))))")
                            .font(.title2)
                           
                    }
                    .bold()
                    .padding(4)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(Color.red.gradient)
                    .cornerRadius(10)
                   
                    
                }
                .foregroundColor(.white)
                
            }
            
            Section(header: Text("Description")) {
                TextField("Enter Description", text: $description)
                
            }
            
            Section {
                HStack {
                    Button(role: .destructive, action: {
                        onCancelForm()
                    }, label: {
                        Text("Cancel")
                            .frame(maxWidth: .infinity)
                    })
                    
                    
                    Button {
                        onSubmitForm()
                    } label: {
                        Text("Add")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .disabled(true)
                }
            }
        }
        .listStyle(.grouped)
    }
    
    func calcSenderValue(total: String, amount: String) -> String {
        let splitAmountDouble = Double(amount) ?? 0.0
        let senderValue = (Double(total) ?? 0.0) - splitAmountDouble
        
        return String(senderValue)
    }
    func calcHalfValue(total: String) -> String {
        let totalDouble = Double(total) ?? 0.0;
        let half = totalDouble  / 2;
        
        return String(half)
        
    }
    func onCancelForm() {
        isShowing.toggle()
        
        print("Cancelled")
        
    }
    
    func onSubmitForm() {
        
        //        isShowing.toggle()
        
        let newTransaction: Transaction = if split == .half {
            Transaction(from: friends[selectedFriendIndex!], to: mainUser, totalAmount: Double(total)!, date: .now, description: description)
        } else {
            Transaction(from: friends[selectedFriendIndex!], to: mainUser, totalAmount: Double(total)!, date: .now, description: description, percantagePaid: Double(splitAmount)!)
        }
        print(newTransaction)
        print("Done")
    }
}

#Preview {
    
    @State var value: Bool = true;
    return AddTransactionForm(isShowing: $value)
}
