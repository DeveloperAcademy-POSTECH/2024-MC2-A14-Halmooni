//
//  MainAddDiaryView.swift
//  Halmooni
//
//  Created by 문인범 on 5/20/24.
//

import SwiftUI
import PhotosUI

struct MainAddDiaryView: View {
    @Environment(\.managedObjectContext) var context
    
    @State private var viewModel: AudioController = AudioController()
    @State private var isCancelBtnPressed: Bool = false
    @State private var stampCount: Int = 0
    @State private var uploadDate: Date = Date()
    @State private var pickedPhoto: PhotosPickerItem?
    @State private var pickedTemplate: Int?
    @State private var image: Image?
    @State private var recordURL: URL?
    @State private var recordTime: TimeInterval?
    @State private var imageData: Data?
    
    @Binding var isPresented: Bool
    
    private let uuid = UUID()
    private let openedDate = Date()
    
    var diary: Diary?
    
    private var possibleTokens: Int {
        let tokenSum = UserDefaults.standard.tokenSum
        let tokenUsed = UserDefaults.standard.tokenUsed
        return tokenSum - tokenUsed
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    PhotosPicker(selection: $pickedPhoto, matching: .images) {
                        Circle()
                            .frame(width: 150)
                            .foregroundStyle(.sec)
                            .overlay {
                                // TODO: - 이미지 회전해서 보이는 것 수정 필요
                                image?
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                            }
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
                            AddDiaryRecordView(viewModel: $viewModel, recordURL: $recordURL, recordTime: $recordTime, uuid: uuid)
                        } label: {
                            HStack {
                                Text("메시지 녹음")
                                Spacer()
                                if recordTime != nil {
                                    Text(recordTime!.getTimeString())
                                        .font(.system(size: 17))
                                        .foregroundStyle(.gry)
                                }
                            }
                        }
                        
                        NavigationLink {
                            AddDiaryTemplateView(pickedTemplate: $pickedTemplate)
                                .background(.bg)
                        } label: {
                            HStack {
                                Text("카드 선택")
                                Spacer()
                                
                                if pickedTemplate != nil {
                                    Text(Template(rawValue: pickedTemplate!)!.getText)
                                        .font(.system(size: 17))
                                        .foregroundStyle(.gry)
                                }
                                
                            }
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
                            
                            DatePicker(selection: $uploadDate, in: openedDate...) { }
                            .labelsHidden()
                            .frame(height: 30)
                            
                        }
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("스탬프 사용")
                                    .font(.system(size: 17))
                                Text("현재 개수 \(possibleTokens)개")
                                    .font(.system(size: 13))
                                    .foregroundStyle(.gry)
                            }
                            
                            Spacer()
                            
                            Text("\(stampCount)개")
                                .foregroundStyle(.gry)
                            
                            Stepper("", value: $stampCount, in: 0...possibleTokens)
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
                        AddDiary()
                    } label: {
                        Text("완료")
                            .bold()
                    }
                    .disabled(!(self.pickedPhoto != nil && self.recordURL != nil && self.pickedTemplate != nil))
                }
            }
        }
        .confirmationDialog("타이틀", isPresented: $isCancelBtnPressed) {
            Button("계속 작성하기", role: .cancel) {
                
            }
            Button("변경 사항 폐기", role: .destructive) {
                viewModel.resetRecording()
                self.isPresented.toggle()
            }
        } message: {
            Text("새로운 기록을 폐기하겠습니까?")
        }
        .task(id: pickedPhoto) {
            do {
                self.image = try await pickedPhoto?.loadTransferable(type: Image.self)
                self.imageData = try await pickedPhoto?.loadTransferable(type: Data.self)
            } catch {
                print("Can't load image!")
            }
        }
        .tint(.prim)
        .onAppear {
            guard let diary = self.diary else {
                print("1111")
                return
            }
            self.stampCount = Int(diary.tokenCount)
            self.image = Image(uiImage: UIImage(data:diary.image!)!)
        }
    }
    
    private func AddDiary() {
        guard let image = self.imageData else {
            return
        }
        // 토큰 추가 수정하기
        let diary = Diary(context: self.context)
        diary.id = self.uuid
        diary.image = image
        diary.pickedTemplate = Int16(self.pickedTemplate!)
        diary.recordUrl = self.recordURL!.absoluteString
        diary.savedDate = self.openedDate
        diary.isRead = false
        diary.tokenCount = Int16(stampCount)
        if !(Date() > self.uploadDate) {
            diary.uploadDate = self.uploadDate
        } else {
            diary.uploadDate = nil
        }
        
        do {
            try self.context.save()
        } catch {
            print("저장 실패~")
        }
        UserDefaults.standard.tokenUsed += self.stampCount
        
        self.isPresented = false
    }
}

#Preview {
    let context = PersistentController.shared.container.viewContext
    
    return MainAddDiaryView(isPresented: .constant(true))
        .environment(\.managedObjectContext, context)
}
