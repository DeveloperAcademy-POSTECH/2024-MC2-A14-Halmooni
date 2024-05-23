//
//  SelectVieww.swift
//  Halmooni
//
//  Created by donghwan on 5/23/24.
//

import Foundation
import SwiftUI

struct SelectView: View {
    @State var isPad: Bool = UIDevice.current.userInterfaceIdiom == .pad

    var body: some View {
        Group {
            if isPad {
                IpadSelectView()
            } else {
                IphoneSelectView()
            }
        }
        .onAppear {
            self.isPad = UIDevice.current.userInterfaceIdiom == .pad
        }
    }
}


#Preview {
    SelectView()
}
