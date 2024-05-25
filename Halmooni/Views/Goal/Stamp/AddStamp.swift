//
//  AddStamp.swift
//  Halmooni
//
//  Created by 추서연 on 5/20/24.
//

import SwiftUI

struct AddStamp: View {
    @State private var showModal = false
    @Binding var tokenSum: Int
    @Binding var tokenUsed: Int
    
    var body: some View {
        VStack {
            Text("우표 추가하기")
                .padding(16)
            
            Button(action: {
                showModal = true
            }, label: {
                Image(systemName: "plus.app")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.prim)
            })
        }
        .frame(width:131, height: 131)
        .padding(16)
        .background(.section)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .sheet(isPresented: $showModal) {
            AddStampDetail(tokenSum: $tokenSum, tokenUsed: $tokenUsed)
        }
    }
}

#Preview {
    AddStamp(tokenSum: .constant(UserDefaults.standard.tokenSum), tokenUsed: .constant(UserDefaults.standard.tokenUsed))
}
