//
//  FeedRow.swift
//  Coffup
//
//  Created by Roderic Campbell on 6/8/19.
//

import SwiftUI

struct FeedRow : View {
    let event: WrappedEvent
    var body: some View {
        VStack {
            Image("turtlerock").shadow(color: .black, radius: 20, x: 10, y: 10)
            HStack {
                VStack(alignment: .leading) {
                    Text(event.name)
                    Text(event.venue.name)
                    Text(event.startDate)
                }
                Spacer()
                }.padding(8)
            }
    }
}

//#if DEBUG
struct FeedRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            FeedRow(event: eventData[0])
//            FeedRow(event: eventData[1])
            }
            .previewLayout(.fixed(width: 300, height: 400))
    }
}
//#endif
