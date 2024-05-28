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
    case letter
    
    var name: String {
        switch self {
        case .goal:
            return "목표 관리"
        case .list:
            return "모아 보기"
        case .letter:
            return "From. 할머니"
        }
    }
}
