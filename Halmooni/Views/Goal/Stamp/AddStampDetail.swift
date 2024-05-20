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
    
    var tokenSum: Int
    var tokenUsed: Int
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("BgColor").edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack{
                        Image(systemName: "star.square.on.square")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color("PrimColor"))
                            .padding(16)
                        
                        Text("남은 우표 수: \(tokenSum - tokenUsed + 1)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        HStack{
                            Text("추가할 우표 수")
                            
                            TextField("Enter Quantity", value: $quantity, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
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
                                .background(Color("SecColor"))
                                .foregroundColor(Color("TextColor"))
                                .cornerRadius(90)
                        }
                        Button(action: {
                            quantity += 10
                        }) {
                            Text("+10")
                                .frame(width: 90, height: 30)
                                .background(Color("SecColor"))
                                .foregroundColor(Color("TextColor"))
                                .cornerRadius(90)
                        }
                        Button(action: {
                            quantity += 15
                        }) {
                            Text("+15")
                                .frame(width: 90, height: 30)
                                .background(Color("SecColor"))
                                .foregroundColor(Color("TextColor"))
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
                                .foregroundColor(Color("PrimColor"))
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            // Add action for done button here
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("완료")
                                .foregroundColor(Color("PrimColor"))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddStampDetail(tokenSum: 15, tokenUsed: 8)
}
