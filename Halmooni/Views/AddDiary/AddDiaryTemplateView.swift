//
//  AddDiaryTemplateView.swift
//  Halmooni
//
//  Created by 문인범 on 5/20/24.
//

import SwiftUI

struct AddDiaryTemplateView: View {
    @State private var image: Image?
    @State private var selectedTemplate: Template?

    @Binding var pickedTemplate: Int?
    
    
    var body: some View {
        VStack {
            // MARK: - 템플릿 선택한 것 보여주기
            
            if selectedTemplate == nil {
                RoundedRectangle(cornerRadius: 5)
                    .aspectRatio(3/4, contentMode: .fit)
                    .foregroundStyle(.section)
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
            } else {
                selectedTemplate!.getImage
                    .resizable()
                    .aspectRatio(3/4, contentMode: .fit)
                    .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 2)
                    .padding(.top, 31)
                    .padding(.bottom, 34)
                
            }
            
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
                    ForEach(Template.allCases, id: \.self) { template in
                        VStack {
                            template.getImage
                                .resizable()
                                .aspectRatio(3/4, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .overlay {
                                    if selectedTemplate == template {
                                        ZStack {
                                            Color.black.opacity(0.5)
                                            
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(lineWidth: 3)
                                                .foregroundStyle(.prim)
                                            
                                            Image(systemName: "checkmark.circle")
                                                .font(.system(size: 30))
                                                .foregroundStyle(.prim)
                                        }
                                    }
                                }
                            
                            Text(template.getText)
                                .font(.footnote)
                        }
                        .onTapGesture {
                            self.selectedTemplate = template
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 5)
            }
            .frame(height: 230)
            .scrollIndicators(.hidden)
        }
        .navigationTitle("카드 선택")
        .onAppear {
            if pickedTemplate != nil {
                selectedTemplate = Template(rawValue: pickedTemplate!)!
            }
        }
        .onDisappear {
            if selectedTemplate != nil {
                pickedTemplate = selectedTemplate!.rawValue
            }
        }
    }
}

#Preview {
    AddDiaryTemplateView(pickedTemplate: .constant(0))
}

