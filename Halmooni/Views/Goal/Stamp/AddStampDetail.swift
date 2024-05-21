//
//  AddStampDetail.swift
//  Halmooni
//
//  Created by 추서연 on 5/20/24.
//

import SwiftUI

struct AddStampDetail: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var quantity = 0
    @Binding var tokenSum: Int
    var tokenUsed: Int
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.bg.edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack {
                        Image(systemName: "star.square.on.square")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color.prim)
                            .padding(16)
                        
                        Text("남은 우표 수: \(tokenSum - tokenUsed + 1)")
                            .font(.caption)
                            .foregroundColor(Color.gry)
                        
                        Spacer()
                        
                        HStack{
                            Text("추가할 우표 수")
                            
                            TextField("갯수 입력", value: $quantity, formatter: positiveNumberFormatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                        }
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(20)
                    }
                    .padding(16)
                    .frame(height: 200)
                    
                    Spacer()
                    
                    HStack {
                        Button(action : {
                            quantity += 5
                        })  {
                            Text("+5")
                                .frame(width: 90, height: 30)
                                .background(Color.sec)
                                .foregroundColor(Color.text)
                                .cornerRadius(90)
                        }
                        Button(action: {
                            quantity += 10
                        }) {
                            Text("+10")
                                .frame(width: 90, height: 30)
                                .background(Color.sec)
                                .foregroundColor(Color.text)
                                .cornerRadius(90)
                        }
                        Button(action: {
                            quantity += 15
                        }) {
                            Text("+15")
                                .frame(width: 90, height: 30)
                                .background(Color.sec)
                                .foregroundColor(Color.text)
                                .cornerRadius(90)
                        }
                    }
                }
                .padding(16)
                .navigationBarTitle("우표 추가", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("취소")
                                .foregroundColor(Color.prim)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            tokenSum += quantity
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("완료")
                                .foregroundColor(Color.prim)
                        }
                    }
                }
            }
        }
    }
    private var positiveNumberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimum = 0
        formatter.maximumFractionDigits = 0
        return formatter
    }
}

#Preview {
    AddStampDetail(tokenSum: .constant(15), tokenUsed: 8)
}
