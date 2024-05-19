//
//  addStampDetail.swift
//  Halmooni
//
//  Created by 추서연 on 5/19/24.
//

import SwiftUI

struct addStampDetail: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var quantity = 0
    
    var tokenSum: Int
    var tokenUsed: Int

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "star.square.on.square")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.primaryColor)
                    .padding(16)
                
                Text("Remaining Stamps: \(tokenSum - tokenUsed + 1)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                TextField("Enter Quantity", value: $quantity, formatter: NumberFormatter())
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    Button(action: {
                        quantity += 5
                    }) {
                        Text("+5")
                            .padding()
                            .background(Color.secondaryColor)
                            .foregroundColor(.black)
                            .cornerRadius(20)
                    }
                    
                    Button(action: {
                        quantity += 10
                    }) {
                        Text("+10")
                            .padding()
                            .background(Color.secondaryColor)
                            .foregroundColor(.black)
                            .cornerRadius(20)
                    }
                }
            }
            .padding(16)
            .background(Color.white)
            .navigationBarTitle("Add Stamp", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                            .foregroundColor(Color.primaryColor)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Add action for done button here
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                            .foregroundColor(Color.primaryColor)
                    }
                }
            }
        }
    }
}

#Preview {
    addStampDetail(tokenSum: 15, tokenUsed: 8)
}
