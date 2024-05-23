//
//  GrandMotherPhoto.swift
//  grandmother
//
//  Created by Kyu Im on 5/18/24.
//

import SwiftUI


struct GrandMotherPhoto: View {
    var image: UIImage?
    var date: Date?
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.green)
                .aspectRatio(3/4, contentMode: .fit)
                .overlay {
                    ZStack {
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        
                        VStack {
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 20)
                                .aspectRatio(15/3, contentMode: .fit)
                                .foregroundColor(Color.black.opacity(0.5))
                                .overlay {
                                    HStack{
                                        Spacer()
                                        if let date = date {
                                            Text(date, style: .date)
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
}

#Preview {
    GrandMotherPhoto()
}
