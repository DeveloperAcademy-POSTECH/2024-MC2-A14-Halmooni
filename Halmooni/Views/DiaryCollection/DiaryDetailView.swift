//
//  DiaryDetailView.swift
//  Halmooni
//
//  Created by Seoyeon Choi on 5/21/24.
//

import SwiftUI

struct DiaryDetailView: View {
    @ObservedObject var presenter: FlipCardPresenter
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var diary: Diary
    
    @State private var isPresented = false
    @State private var isDeleted: Bool = false
    
    var body: some View {
        ZStack{
            Color.bg
            //기록카드 뷰
            ImageCard(presenter: presenter, diary: diary)
            //수정, 삭제하기 툴바
                .toolbar{
                    ToolbarItem{
                        Menu(content: {
                            Button(action: {
                                // TODO: 수정하기 기능 추가
                                isPresented = true
                            }, label: {
                                HStack{
                                    Text("수정하기")
                                        .foregroundStyle(.gry)
                                    Image(systemName: "pencil")
                                        .foregroundStyle(.gry)
                                }
                            })
                            
                            Button(role: .destructive, action: {
                                isDeleted.toggle()
                            }, label: {
                                HStack{
                                    Text("삭제하기")
                                        .foregroundColor(.prim)
                                    Image(systemName: "trash.fill")
                                        .tint(.prim)
                                }
                            })
                        }, label: {
                            Image(systemName: "ellipsis.circle")
                                .foregroundStyle(.prim)
                        })
                        .alert(isPresented: $isDeleted) {
                            Alert(title: Text("삭제"), message: Text("이 기록을 삭제하시겠습니까?"), primaryButton: .cancel(Text("취소")), secondaryButton: .default(Text("확인"), action: {
                                PersistentController.shared.deleteDiary(diary: diary)
                                self.presentationMode.wrappedValue.dismiss()
                            }))
                        }
                        
                    }
                }
            //            if isPresented {
            //                MainAddDiaryView(isPresented: $isPresented)
            //            }
        }
        .toolbar(.hidden, for: .tabBar)
        .ignoresSafeArea()
    }
}

// MARK: - 상세보기뷰: 우표템플릿
struct ImageCard: View {
    @ObservedObject var presenter: FlipCardPresenter
    @State private var isAnimating: Bool = false
    @State private var viewModel: AudioViewModel = AudioViewModel()
    @State private var audioController: AudioController = AudioController()
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    let diary: Diary
    
    
    var body: some View {
        //우표템플릿
        VStack {
            Spacer()
            ZStack{
                fullPostColorSchemeImage
                    .resizable()
                    .frame(width: 361, height: 571)
                //날짜, 음성재생 버튼
                VStack{
                    HStack{
                        if let date = diary.uploadDate ?? diary.savedDate {
                            let dateString = dateNumberFormatter.string(from: date)
                            
                            Text("\(dateString)")
                                .font(.title2)
                                .bold()
                                .padding(.leading, 32)
                            Spacer()
                            
                            switch viewModel.status {
                            case .loading:
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .padding(.trailing, 32)
                            case .success:
                                Button(action: {
                                    guard let path = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appending(path: "Documents") else {
                                        return
                                    }
                                    let url = path.appending(path: "\(diary.id!.uuidString).m4a")
                                    
                                    AudioController().startAudio(filePath: url)
                                }, label: {
                                    PlayButton()
                                        .foregroundStyle(.text)
                                        .padding(.trailing, 32)
                                })
                            case .failed:
                                Text("로딩 실패")
                            }
                        }
                    }
                    .padding(.top, 30)
                    Spacer()
                }
                //카드 이미지
                FlipCard(presenter: presenter, isAnimating: $isAnimating, diary: diary)
                    .rotation3DEffect(.degrees(isAnimating ? 5 : 0), axis: (x: 0, y: 1, z: 0))
                    .animation(
                        isAnimating ?
                        Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true) : .default ,
                        value: isAnimating
                    )
                    .rotation3DEffect(.degrees(presenter.isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                    .animation(.default, value: presenter.isFlipped)
                    .onAppear {
                        isAnimating = true
                    }
                    .onDisappear {
                        presenter.isFlipped = false //카드 뒤집힌 상태 초기화
                    }
            }
            .frame(width: 361, height: 571)
            .onAppear {
                self.viewModel.downloadRecordFile(url: diary.recordUrl!)
            }
            .onDisappear {
                self.audioController.stopAudio()
            }
            Spacer()
                .frame(height: 112)
        }
    }
    
    // MARK: - fullPost 이미지 colorScheme 설정
    private var fullPostColorSchemeImage: Image {
        colorScheme == .dark ? Image("fullPost_dark") : Image("fullPost")
    }
    
    // MARK: - 날짜(0월0일) 추출되도록
    private var dateNumberFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일"
        return formatter
    }
}

// MARK: - 음성재생버튼
struct PlayButton: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 90)
                .frame(width: 90, height: 30)
                .foregroundStyle(.sec)
            HStack(spacing: 0){
                Text("음성 재생 ")
                    .font(.system(size: 13))
                Image(systemName: "play.circle")
                    .font(.system(size: 13))
            }
        }
    }
}

// MARK: - 이미지카드 + 사용한 토큰
struct FlipCard: View {
    @ObservedObject var presenter: FlipCardPresenter
    @Binding var isAnimating: Bool
    let diary: Diary
    
    var body: some View {
        ZStack{
            //이미지카드
            VStack{
                Spacer()
                if let imgData = diary.image, let uiImage = UIImage(data: imgData){
                    Image(uiImage: presenter.isFlipped ? UIImage(imageLiteralResourceName: "\(diary.pickedTemplate).png") : uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 294, height: 393)
                        .clipped()
                        .cornerRadius(15)
                        .scaleEffect(x: presenter.isFlipped ? -1 : 1, y: 1)
                        .shadow(color: .gry, radius: 4, y: 4)
                        .overlay{
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    // MARK: 사용한 토큰 우표
                                    ZStack{
                                        Image(.tokenPost)
                                            .resizable()
                                            .frame(width: 78, height: 52)
                                        HStack(spacing: 0){
                                            Image(systemName: "heart.fill")
                                                .font(.system(size: 22))
                                                .foregroundStyle(.black)
                                            Text(" \(diary.tokenCount)")
                                                .font(.title2)
                                                .bold()
                                                .font(.system(size: 22))
                                                .foregroundStyle(.black)
                                        }
                                    }
                                    .padding(.bottom, 20)
                                    .padding(.trailing, 20)
                                }
                            }
                            .scaleEffect(x: presenter.isFlipped ? -1 : 1, y: 1)
                            .opacity(presenter.isFlipped ? 1 : 0)
                        }
                        .padding(.bottom, 57)
                        .onTapGesture {
                            presenter.flipButtonTapped()
                            isAnimating = false
                        }
                }
                
            }
        }
    }
}

// MARK: - 카드플립을 위한 protocol, class
protocol FlipCardPresenterProtocol: ObservableObject {
    var isFlipped: Bool { get }
    func flipButtonTapped()
}

class FlipCardPresenter: FlipCardPresenterProtocol {
    @Published var isFlipped: Bool = false
    
    func flipButtonTapped() {
        isFlipped.toggle()
    }
}


