import SwiftUI
import UIKit


//detailView 호출시 블러 처리하는 것
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = effect
    }
}

struct GrandMotherMainView: View {
    @State private var select: Bool = false
    @State private var showDetailView: Bool = false
    @Namespace private var animationNameSpace
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    private let phoneNumber = "010-5594-7259"
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 122),
        GridItem(.flexible(), spacing: 122)
    ]
    
    private var imageColorScheme: Image {
        colorScheme == .dark ? Image(.halviewdark) : Image(.halviewlight)
    }
    
    
    @FetchRequest(entity: Diary.entity(), sortDescriptors: [.init(keyPath: \Diary.savedDate, ascending: true)])
    var diaries:FetchedResults<Diary>
    
    @State var selectedDiary: Diary?
    
    var body: some View {
        
        ZStack {
            Color.bg.ignoresSafeArea()
            
            imageColorScheme

            VStack {
                    
                    // TODO: 전화 연결 클라우드 사용 방안으로 변경
                    Button(action: {
                        makeFaceTimeCall(phoneNumber: phoneNumber)
                    }) {
//                        let telephone = "tel://"
//                        let formattedString = telephone + numberString
//                        guard let url = URL(string: formattedString) else { return }
//                        UIApplication.shared.open(url)
                        ZStack {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(.section)
                                .shadow(color:Color.black.opacity(0.15), radius: 15, x: 0, y: 2)
                            
                            HStack {
                                Text("인범이에게 전화하기")
                                    .dynamicTypeSize(.xxxLarge)
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.text)
                                    .padding(.leading, 44)

                                
                                Image(systemName: "phone.circle.fill")
                                    .foregroundColor(.green)
                                    .dynamicTypeSize(.xxxLarge)
                                    .font(.largeTitle)
                                    .padding(.trailing, 44)
                            }
                            
                        }
                        .frame(width: 502, height: 92)
                        
                    }
                    .padding(.top, 90)
                    .padding(.trailing, 140)
                    .padding(.leading, 750)
                
                Spacer()
                    .frame(height: 65)
                
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 44) {
                        ForEach(diaries.indices) { index in
                            ZStack {
//                              //TODO: - 사진위치에 따른 애니메이션 변경 기능 추가
                                    GrandMotherPhoto(
                                        image: UIImage(data: diaries[index].image!),
                                        date: diaries[index].savedDate
                                    )
//                                        .fill(Color.sec) // 색상 추가 (선택 사항)
//                                        .padding(.leading, 50)
                                //TODO: - 좌우 프레임 padding  조정하기
                                        .frame(width: 502, height: 670)
                                        .aspectRatio(3/4, contentMode: .fit)
                                        .matchedGeometryEffect(id: "diary.id", in: animationNameSpace)
                                        .shadow(color:Color.black.opacity(0.15), radius: 15, x: 0, y: 0)
                                        .padding(index % 2 == 0 ? .leading: .trailing, 120)
                                        .overlay {
                                            if !self.select {
                                                GifView(gifName: "NewMessage")
                                                    .frame(width: 502, height: 670)
                                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                                    .padding(index % 2 == 0 ? .leading: .trailing, 120)
                                            }
                                        }
                                
                                
//                                }
                            }
                            .onTapGesture {
                                self.selectedDiary = diaries[index]
                                withAnimation{
                                    showDetailView.toggle()
                                }
                            }
                        }
                    }

                } //ScrollView
            }
            if showDetailView {
                VisualEffectView(effect: UIBlurEffect(style: .light))
                    .edgesIgnoringSafeArea(.all)
                
                
                GrandMotherDetailView(showDetailView: $showDetailView, animationNamespace: animationNameSpace, diary: self.selectedDiary!)

                //detailview 임의 설정
                    .frame(width:1026, height: 912)
                    .cornerRadius(20)
            }
        }
        
        
    }
    func makeFaceTimeCall(phoneNumber: String) {
        let faceTimeURLString = "facetime://\(phoneNumber)"
        if let faceTimeURL = URL(string: faceTimeURLString) {
            if UIApplication.shared.canOpenURL(faceTimeURL) {
                UIApplication.shared.open(faceTimeURL, options: [:], completionHandler: nil)
            } else {
                print("FaceTime을 열 수 없습니다.")
            }
        }
    }
}



#Preview {
    GrandMotherMainView()
}
