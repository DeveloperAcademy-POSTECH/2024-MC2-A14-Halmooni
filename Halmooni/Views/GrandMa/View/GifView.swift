//
//  GifView.swift
//  Halmooni
//
//  Created by Kyu Im on 5/21/24.
//

import SwiftUI
import UIKit

struct GifView: UIViewRepresentable {
    let gifName: String

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        
        guard let gifUrl = Bundle.main.url(forResource: gifName, withExtension: "GIF") else {
//            fatalError("GIF 파일을 찾을 수 없습니다.")
            print("울랄라")
            return UIImageView()
        }

        guard let gifData = try? Data(contentsOf: gifUrl) else {
//            fatalError("GIF 파일을 로드할 수 없습니다.")
            print("안됨!")
            return UIImageView()
        }

        imageView.loadGif(data: gifData)
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        // 필요한 경우에만 업데이트
    }
}
extension UIImageView {
    func loadGif(data: Data) {
        DispatchQueue.global().async {
            guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
                return
            }

            let count = CGImageSourceGetCount(source)
            var images = [UIImage]()

            for i in 0..<count {
                if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                    images.append(UIImage(cgImage: cgImage))

                }
            }

            DispatchQueue.main.async {
                self.animationImages = images
                self.animationDuration = Double(count) * 0.3
                self.startAnimating()
            }
        }
    }
}

