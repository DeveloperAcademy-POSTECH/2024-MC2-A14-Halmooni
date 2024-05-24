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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.clear)
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
                }
        }
    }
}

#Preview {
    GrandMotherPhotos()
}
