//
//  TimeInterval + Extension.swift
//  Halmooni
//
//  Created by 문인범 on 5/21/24.
//

import Foundation

extension TimeInterval {
    func getTimeString() -> String {
        let minute = Int(self) / Int(60)
        let secondPointTwo = (self - Double(minute * 60))
        
        var minuteString: String
        var secondString: String
        
        if minute < 10 {
            minuteString = "0\(minute)"
        } else {
            minuteString = "\(minute)"
        }
        
        if secondPointTwo < 10 {
            secondString = "0\(String(format: "%.2f", secondPointTwo))"
        } else {
            secondString = String(format: "%.2f", secondPointTwo)
        }
        return "\(minuteString):\(secondString)"
    }
}
