//
//  GrandMotherPhotos.swift
//  Halmooni
//
//  Created by Kyu Im on 5/23/24.
//

import SwiftUI
extension Date {
    func engToKor() -> String {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy년 M월 d일"
        let dateString = myFormatter.string(from: self)
        
        return dateString
    }
}
struct GrandMotherPhotos: View {
    var image: UIImage?
    var date: Date?
    let namespace: Namespace.ID
    let index: Int
    
    var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .matchedGeometryEffect(id: "\(index)", in: namespace)
                    .scaledToFit()
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
                                Text(date.engToKor())
                                    .font(.largeTitle.bold())
                                    .dynamicTypeSize(.accessibility1)
                                    .foregroundStyle(Color.white)
                                    .padding(40)
                            }
                        }
                    }
            }
        }
        .background(.bg)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
}
