//
//  ProgressBar.swift
//  Halmooni
//
//  Created by 추서연 on 5/26/24.
//
struct ProgressBar: View {
    var currentTime: TimeInterval
    var audioLength: TimeInterval

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.3))
                    .frame(width: geometry.size.width, height: 8)
                Rectangle()
                    .foregroundColor(Color.blue)
                    .frame(width: min(self.progressWidth(geometry: geometry), geometry.size.width), height: 8)
            }
        }
    }

    private func progressWidth(geometry: GeometryProxy) -> CGFloat {
        let progress = CGFloat(currentTime / audioLength)
        return progress * geometry.size.width
    }
}
