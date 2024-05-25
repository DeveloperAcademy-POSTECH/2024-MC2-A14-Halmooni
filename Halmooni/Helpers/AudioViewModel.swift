//
//  AudioViewModel.swift
//  Halmooni
//
//  Created by 문인범 on 5/25/24.
//

import SwiftUI


@Observable
class AudioViewModel {
    public var status: ModelStatus = .loading
    
    public func downloadRecordFile(url: String) {
        guard let path = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appending(path: "Documents") else {
            print("failed to make url")
            return
        }
        let fileName = url.split(separator: "/").last!
        let fileUrl = path.appending(path: fileName)
        
        do {
            try FileManager.default.startDownloadingUbiquitousItem(at: fileUrl)
        } catch {
            self.status = .failed
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.status = .success
        }
    }
    
    enum ModelStatus {
        case loading
        case success
        case failed
    }
}
