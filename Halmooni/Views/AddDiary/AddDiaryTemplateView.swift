//
//  AddDiaryTemplateView.swift
//  Halmooni
//
//  Created by 문인범 on 5/20/24.
//

import SwiftUI

struct AddDiaryTemplateView: View {
    @State private var image: Image?
    @Binding var pickedTemplate: Int?
    
    var body: some View {
        VStack {
            // MARK: - 템플릿 선택한 것 보여주기
            RoundedRectangle(cornerRadius: 20)
                .aspectRatio(3/5, contentMode: .fit)
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 2)
                .overlay {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 80)
                        .foregroundStyle(.sec)
                }
                .padding(.top, 31)
                .padding(.bottom, 34)
            
            
            HStack {
                Text("템플릿 선택")
                    .font(.subheadline)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            
            
            ScrollView(.horizontal) {
                // TODO: - 나중에 ForEach로 수정, 선택 기능 구현
                HStack {
                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .aspectRatio(3/5, contentMode: .fit)
                            .foregroundStyle(.orange)
                        
                        Text("뿡칫뿡칫")
                            .font(.footnote)
                    }
                    .onTapGesture {
                        
                    }
                    
                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .aspectRatio(3/5, contentMode: .fit)
                            .foregroundStyle(.orange)
                        
                        Text("비눗방울")
                            .font(.footnote)
                    }
                    
                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .aspectRatio(3/5, contentMode: .fit)
                            .foregroundStyle(.orange)
                        
                        Text("구름구름")
                            .font(.footnote)
                    }
                    
                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .aspectRatio(3/5, contentMode: .fit)
                            .foregroundStyle(.orange)
                        
                        Text("무니무니")
                            .font(.footnote)
                    }
                    

                }
                .padding(.leading, 16)
            }
            .frame(height: 230)
        }
        .navigationTitle("카드 선택")
        
    }
}

#Preview {
    AddDiaryTemplateView(pickedTemplate: .constant(0))
}
