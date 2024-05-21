//
//  GrandMotherPhoto.swift
//  grandmother
//
//  Created by Kyu Im on 5/18/24.
//

import SwiftUI


struct GrandMotherPhoto: View {
    var body: some View {
       
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.green)
                .aspectRatio(3/4, contentMode: .fit)
                .overlay {
                    ZStack {
                        VStack {
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 20)
                                .aspectRatio(15/3, contentMode: .fit)
                                .foregroundColor(Color.black.opacity(0.5))
                                .overlay {
                                    HStack{
                                        Spacer()
                                        Text("YYYY년 MM월 DD일")
                                            .font(.largeTitle.bold())
                                            .dynamicTypeSize(.accessibility3)
                                            .foregroundStyle(Color.white)
                                            .padding(40)
                                    }
                                }
                        }
                    }
                }
        }
                
            
        
    }
}

#Preview {
    GrandMotherPhoto()
}
