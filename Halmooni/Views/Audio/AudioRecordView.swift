//
//  AudioRecordView.swift
//  Halmooni
//
//  Created by 추서연 on 5/21/24.
//

import SwiftUI

struct AudioRecordView: View {
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                ProgressBar(audioRecorder: AudioRecorder)
            }
            .padding(16)
        }
    }
}

#Preview {
    AudioRecordView()
}
