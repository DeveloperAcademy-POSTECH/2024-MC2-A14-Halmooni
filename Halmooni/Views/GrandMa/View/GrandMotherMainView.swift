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
    
    
    let phoneNumber = "010-2557-0122"
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 90),
        GridItem(.flexible(), spacing: 90)
    ]
    
    
    var body: some View {
        
        ZStack {
            Color.bg.ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("To. 할무니")
                        .font(.largeTitle.bold())
                        .dynamicTypeSize(.xxxLarge)
                        .padding(.leading, 60)

                    
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
                                .fill(.white)
                            HStack {
                                Text("인범이에게 전화하기")
                                    .dynamicTypeSize(.xxxLarge)
                                    .font(.largeTitle)
                                    .foregroundColor(.text)
                                    .bold()
                                    .padding(.leading, 46)
                                
                                Spacer()
                                
                                Image(systemName: "phone.circle.fill")
                                    .foregroundColor(.green)
                                    .dynamicTypeSize(.xxxLarge)
                                    .font(.largeTitle)
                                    .padding(.trailing, 33)
                            }
                            
                        }
                        .frame(width: 592, height: 100)
                        
                    }
                    .padding(.top, 65)
                    .padding(.trailing, 60)
                    .padding(.leading, 370)
                }
                Spacer()
                    .frame(height: 65)
                
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                        ForEach(0..<2) { i in
                            ZStack {
                              //TODO: - 사진위치에 따른 애니메이션 변경 기능 추가

                                VStack {
                                    if i % 2 == 0 {
                                        // 짝수번 (왼쪽)
                                    }
                                    else {
                                        // 홀수번 (오른쪽)
                                    }
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.sec) // 색상 추가 (선택 사항)
                                        .padding(i % 2 == 0 ? .leading: .trailing, 90)
//                                        .padding(.leading, 50)
                                        .aspectRatio(3/4, contentMode: .fit)
                                        .matchedGeometryEffect(id: "photo\(i)", in: animationNameSpace)
                                        .shadow(color:Color.black.opacity(0.15), radius: 15, x: 0, y: 0)

                                }
                                
                                if !self.select {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.white)
                                    GifView(gifName: "NewMessage")
//                                    Image(systemName: "photo.artframe")
//                                        .font(.largeTitle)
                                }
                                
                            }
                            .onTapGesture {
                                withAnimation{
                                    showDetailView.toggle()
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 90)
                }
            }
            if showDetailView {
                VisualEffectView(effect: UIBlurEffect(style: .light))
                    .edgesIgnoringSafeArea(.all)
                
                GrandMotherDetailView(showDetailView: $showDetailView, animationNamespace: animationNameSpace)
//                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                    //.transition(.opacity)
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
