//
//  Title.swift
//  Halmooni
//
//  Created by Seoyeon Choi on 5/20/24.
//

import Foundation

enum Title {
    case goal
    case list
    
    var name: String {
        switch self {
        case .goal:
            return "목표 관리"
        case .list:
            return "모아 보기"
        }
    }
}
