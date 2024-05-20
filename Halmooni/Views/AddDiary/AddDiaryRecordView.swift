//
//  AddDiaryRecordView.swift
//  Halmooni
//
//  Created by 문인범 on 5/20/24.
//

import SwiftUI


// TODO: - 녹음 기능 구현
struct AddDiaryRecordView: View {
    var body: some View {
        VStack {
            Spacer()
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.prim)
                .frame(height: 120)
                .padding(.horizontal, 15)

            Text("02:10.23")
                .font(.largeTitle)
                .bold()
                .padding(.top, 80)
                .padding(.bottom, 40)
            
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "gobackward.15")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "play.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 45, height: 45)
                }
                .padding(.leading, 40)
                .padding(.trailing, 30)
                
                Button {
                    
                } label: {
                    Image(systemName: "goforward.15")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.bottom, 80)
            
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 4)
                        .foregroundStyle(.prim)
                        .frame(width: 108, height: 50)
                    
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.sec)
                        .frame(width: 108, height: 50)
                    
                    Text("재개")
                }
            }
            
            Spacer()
        }
        .navigationTitle("메시지 녹음")
        .background(.bg)
    }
}

#Preview {
    AddDiaryRecordView()
}
