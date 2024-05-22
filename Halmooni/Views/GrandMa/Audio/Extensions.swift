//
//  Extensions.swift
//  Halmooni
//
//  Created by 추서연 on 5/21/24.
//

import Foundation

extension Date
{
    func toString(dateFormat format: String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
