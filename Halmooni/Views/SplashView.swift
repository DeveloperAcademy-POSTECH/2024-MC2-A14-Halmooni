//
//  SplashView.swift
//  Halmooni
//
//  Created by ChoMinKyung on 5/20/24.
//

import SwiftUI

struct SplashView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        ZStack(alignment: .topLeading){
            Color(.bg)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 150)
                Text("To.할무니")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.text))
                    .multilineTextAlignment(.leading)
                Text("할머니께 보내는 편지")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.text))
                    .multilineTextAlignment(.leading)
                
                if colorScheme == .dark {
                    Image(.logoDark)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                } else {
                    Image(.logoLight)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                }
            }
            .padding()
        }
    }
}


#Preview {
    SplashView()
}
