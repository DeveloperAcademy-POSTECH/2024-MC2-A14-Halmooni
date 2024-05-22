//
//  Template.swift
//  Halmooni
//
//  Created by 문인범 on 5/22/24.
//

import SwiftUI

// MARK: - 템플릿 enum
enum Template: Int, CaseIterable {
    case zero = 0
    case one, two, three, four, five, six, seven, eight, nine, ten
    case eleven, twelve, thirteen
    
    var getImage: Image {
        switch self {
        case .zero:
            Image(._0)
        case .one:
            Image(._1)
        case .two:
            Image(._2)
        case .three:
            Image(._3)
        case .four:
            Image(._4)
        case .five:
            Image(._5)
        case .six:
            Image(._6)
        case .seven:
            Image(._7)
        case .eight:
            Image(._8)
        case .nine:
            Image(._9)
        case .ten:
            Image(._10)
        case .eleven:
            Image(._11)
        case .twelve:
            Image(._12)
        case .thirteen:
            Image(._13)
        }
    }
    
    var getText: String {
        switch self {
        case .zero:
            "오늘도 행복"
        case .one:
            "하트뿅뿅"
        case .two:
            "별빛달빛"
        case .three:
            "장군이"
        case .four:
            "응원해요"
        case .five:
            "보고싶어요"
        case .six:
            "초록초록"
        case .seven:
            "건강기원"
        case .eight:
            "감사"
        case .nine:
            "사랑합니다"
        case .ten:
            "인범이와 친구들"
        case .eleven:
            "만수무강"
        case .twelve:
            "꽃보다 인범"
        case .thirteen:
            "차은우"
        }
    }
}
