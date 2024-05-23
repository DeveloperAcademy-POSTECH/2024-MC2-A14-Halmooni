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
                if colorScheme == .dark {
                    /*Image(.logoDark)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .padding(30)*/
                    Image(.splashDark)
                } else {
                    /*Image(.logoLight)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .padding(30)*/
                    Image(.splashLight)
                }
                
                Text("To. 할무니")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.text))
                    .multilineTextAlignment(.trailing)
                    .padding(30)
                
                Text("할머니께 보내는 편지")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.text))
                    .multilineTextAlignment(.trailing)
                    .padding(.horizontal, 30)
            }
            .padding()
        }
    }
}


#Preview {
    SplashView()
}
