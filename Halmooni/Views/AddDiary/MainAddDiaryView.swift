//
//  MainAddDiaryView.swift
//  Halmooni
//
//  Created by 문인범 on 5/20/24.
//

import SwiftUI
import PhotosUI

struct MainAddDiaryView: View {
    @State private var isCancelBtnPressed: Bool = false
    @State private var stampCount: Int = 0
    @State private var uploadDate: Date = Date()
    @State private var pickedPhoto: PhotosPickerItem?
    @State private var pickedTemplate: Int?
    @State private var image: Image?
    
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Circle()
                        .frame(width: 150)
                        .foregroundStyle(.sec)
                        .overlay {
                            image?
                                .resizable()
                                .frame(width: 150, height: 150)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                        }
                    if pickedPhoto == nil {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 65)
                            .foregroundStyle(.bg)
                        
                    }
                }
                .padding(.top, 47)
                .padding(.bottom, 21)
                    
                
                PhotosPicker(selection: $pickedPhoto, matching: .images) {
                    ZStack {
                        Capsule()
                            .foregroundStyle(.prim.opacity(0.7))
                            .frame(width: 100, height: 34)
                        
                        Text("사진 추가")
                            .foregroundStyle(.white)
                            .font(.subheadline)
                    }
                }
                
                List {
                    Section {
                        NavigationLink {
                            AddDiaryRecordView()
                        } label: {
                            Text("메시지 녹음")
                        }
                        
                        NavigationLink {
                            AddDiaryTemplateView(pickedTemplate: $pickedTemplate)
                                .background(.bg)
                        } label: {
                            Text("카드 선택")
                        }
                        
                        NavigationLink {
                            
                        } label: {
                            Text("미모티콘")
                        }
                        
                    }
                    
                    Section {
                        HStack {
                            Text("발송 날짜")
                            
                            Spacer()
                            
                            DatePicker(selection: $uploadDate) {
                                
                            }
                            .labelsHidden()
                            .frame(height: 30)
                            
                        }
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("스탬프 사용")
                                    .font(.system(size: 17))
                                Text("현재 개수 123개")
                                    .font(.system(size: 13))
                                    .foregroundStyle(.gry)
                            }
                            
                            Spacer()
                            
                            Text("\(stampCount)개")
                            
                            Stepper {
                                
                            } onIncrement: {
                                stampCount += 1
                            } onDecrement: {
                                if stampCount == 0 {
                                    return
                                }
                                stampCount -= 1
                            }
                            .labelsHidden()
                        }
                        
                    }
                }
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
                .offset(y: -20)
                
            }
            .background(.bg)
            .navigationTitle("글쓰기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        self.isCancelBtnPressed.toggle()
                    } label: {
                        Text("취소")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // TODO: - diary 저장 구현
                    } label: {
                        Text("완료")
                            .bold()
                    }
                }
            }
        }
        .confirmationDialog("타이틀", isPresented: $isCancelBtnPressed) {
            Button("계속 작성하기", role: .cancel) {
                
            }
            Button("변경 사항 폐기", role: .destructive) {
                self.isPresented.toggle()
            }
        } message: {
            Text("새로운 기록을 폐기하겠습니까?")
        }
        .task(id: pickedPhoto) {
            do {
                self.image = try await pickedPhoto?.loadTransferable(type: Image.self)
            } catch {
                print("Can't load image!")
            }
        }
        .tint(.prim)
    }
}

#Preview {
    MainAddDiaryView(isPresented: .constant(true))
}
