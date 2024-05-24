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
            Color(.section)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 150)
                if colorScheme == .dark {
                    Image(.splashDark)
                } else {
                    Image(.splashLight)
                }
            }
            .padding()
        }
    }
}


#Preview {
    SplashView()
}
