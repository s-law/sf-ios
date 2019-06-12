//
//  TransitButtonView.swift
//  Coffup
//
//  Created by Roderic Campbell on 6/10/19.
//

import SwiftUI

struct TransitButtonView : View {
    var body: some View {
        return HStack {
            Button(action: {
                
            }) {
                Image("icon-transport-type-automobile")
                    .shadow(radius: 4)
                    .offset(CGSize(width: 4, height: 4))
            }
            Button(action: {
                
            }) {
                Image("icon-transport-type-transit")
                    .shadow(radius: 4)
                    .offset(CGSize(width: 4, height: 4))
            }
            Button(action: {
                
            }) {
                Image("icon-transport-type-uber")
                    .shadow(radius: 4)
                    .offset(CGSize(width: 4, height: 4))
            }
            Button(action: {
                
            }) {
                Image("icon-transport-type-walking")
                    .shadow(radius: 4)
                    .offset(CGSize(width: 4, height: 4))
            }
            Spacer()
            }.padding(8)
    }
}

//#if DEBUG
struct TransitButtonView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            TransitButtonView()
            }
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
//#endif
