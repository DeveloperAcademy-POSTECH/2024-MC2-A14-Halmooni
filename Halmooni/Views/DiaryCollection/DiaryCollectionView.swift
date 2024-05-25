//
//  DiaryCollectionView.swift
//  Halmooni
//
//  Created by Seoyeon Choi on 5/21/24.
//

import SwiftUI


struct DiaryCollectionView: View {
    @State private var isPresented: Bool = false
    // 삭제 알럿창 전용
    @State private var isDeleted: Bool = false
    @State private var selectedButton: String = " "
    // 다크모드, 라이트모드 관리
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    // 클라우드 데이터 받아오기
    @FetchRequest(entity: Diary.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Diary.uploadDate, ascending: true)])
    var diaries: FetchedResults<Diary>
    
    // 삭제 시 클릭한 데이터 받아오는 변수
    @State var selectedDiary: Diary?
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.bg
                    .ignoresSafeArea(.all)
                ScrollView {
                    ForEach(Array(diaryPosts().keys).sorted{
                        Int($0)! > Int($1)! }, id: \.self) { key in
                        VStack(spacing: 0){
                            ZStack{
                                postColorSchemeImage
                                    .resizable()
                                    .frame(width: 361)
                                    .padding(.top, 32)
                                
                                HStack{
                                    Text("\(key)月")
                                        .font(.title2)
                                        .bold()
                                        .padding(.leading, 32)
                                        .padding(.top, 48)
                                    
                                    Spacer()
                                }
                            }
                            
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                                if let diaryList = diaryPosts()[key] {
                                    ForEach(diaryList) { post in
                                        // 일 변환 상수
                                        if let date = post.uploadDate ?? post.savedDate {
                                            let dayString = dayNumberFormatter.string(from: date)
                                            
                                            NavigationLink(destination: {
                                                DiaryDetailView(presenter: FlipCardPresenter(), diary: post).ignoresSafeArea()}) {
                                                    ZStack{
                                                        if let imgData = post.image, let uiImage = UIImage(data: imgData){
                                                            Image(uiImage: uiImage)
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fill)
                                                                .frame(width: 161, height: 215)
                                                                .contextMenu {
                                                                    // 수정
                                                                    Button("수정", systemImage: "pencil") {
                                                                        // TODO: 수정 기능 삽입 필요
                                                                        self.isPresented.toggle()
                                                                    }
                                                                    // 삭제
                                                                    Button("삭제", systemImage: "trash.fill", role: .destructive) {
                                                                        selectedDiary = post
                                                                        isDeleted.toggle()
                                                                    }
                                                                }
                                                                .alert(isPresented: $isDeleted) {
                                                                    Alert(title: Text("삭제"), message: Text("이 기록을 삭제하시겠습니까?"), primaryButton: .cancel(Text("취소")), secondaryButton: .default(Text("확인"), action: {
                                                                        if let selectedDiary = selectedDiary {
                                                                                    PersistentController.shared.deleteDiary(diary: selectedDiary)
                                                                                }
                                                                    }))
                                                                }
                                                        }
                                                        
                                                        //날짜, 전송예약
                                                        VStack{
                                                            Spacer()
                                                            ZStack{
                                                                Rectangle()
                                                                    .frame(width: 161, height: 34)
                                                                    .foregroundStyle(Color.black)
                                                                    .opacity(0.5)
                                                                HStack(spacing: 0){
                                                                    Spacer()
                                                                    
                                                                    if isFutureDate(date: (post.uploadDate ?? post.savedDate)!) {
                                                                        WillSendIndicatior()
                                                                            .padding(.trailing, 16)
                                                                    }
                                                                    
                                                                    Text("\(dayString)일")
                                                                        .font(.headline)
                                                                        .foregroundStyle(Color.white)
                                                                        .lineLimit(1)
                                                                        .minimumScaleFactor(0.5)
                                                                        .padding(.trailing, 13)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                        }
                                    }
                                }
                            }
                            .padding([.leading, .trailing], 32)
                            .padding(.bottom, 16)
                            .background{
                                Rectangle()
                                    .foregroundStyle(.section)
                                    .frame(width: 361)
                            }
                            
                            Spacer()
                        }
                    }
                }
            }
            .toolbarBackground(.bg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .accentColor(.accentColor)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        isPresented.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.prim)
                    })
                }
            }
            .navigationTitle(Title.list.name)
            .sheet(isPresented: $isPresented) {
                MainAddDiaryView(isPresented: $isPresented)
            }
        }
    }
    
    
    // MARK: - 현재 날짜와 비교하는 함수
    private func isFutureDate(date: Date) -> Bool {
        let currentDate = Date()
        return date > currentDate
    }
    
    // MARK: - 날짜(월) 숫자만 추출되도록
    var monthNumberFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M"
        return formatter
    }
    
    // MARK: - 날짜(일) 숫자만 추출되도록
    var dayNumberFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
    
    
    
    // MARK: - 배열 내 데이터 추가
    func diaryPosts() -> [String: [Diary]] {
        var diaryDate = [String: [Diary]] ()
        var monthFlag = "0"
        
        for diary in self.diaries {
            let month = diary.uploadDate ?? diary.savedDate!
            print(month)
            
//            if let month = diary.uploadDate ?? diary.savedDate {
                let monthString = monthNumberFormatter.string(from: month)
                
                if monthString != monthFlag {
                    monthFlag = monthString
                    diaryDate[monthString] = []
                    diaryDate[monthString]!.append(diary)
                    continue
                }
                
                diaryDate[monthString]!.append(diary)
//            }
        }
        print(diaryDate.values)
        return diaryDate
    }
    
    // MARK: - post 이미지 colorScheme 설정
    private var postColorSchemeImage: Image {
        colorScheme == .dark ? Image("post_dark") : Image("post")
    }
}

// MARK: - 전송예약 아이콘
@ViewBuilder
func WillSendIndicatior() -> some View {
    ZStack{
        ZStack{
            RoundedRectangle(cornerRadius: 90)
                .foregroundStyle(.white)
                .frame(width: 90, height: 20)
            HStack(spacing: 0){
                Text("전송 예정 ")
                    .font(.caption2)
                    .foregroundStyle(.prim)
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.prim)
                
            }
        }
    }
}

#Preview {
    DiaryCollectionView()
}
