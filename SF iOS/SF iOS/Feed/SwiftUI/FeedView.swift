//
//  FeedView.swift
//  Coffup
//
//  Created by Roderic Campbell on 6/8/19.
//

import SwiftUI

struct FeedView : View {
    let myEvents: [WrappedEvent]
    var body: some View {
        NavigationView {
            List(eventData.identified(by: \.eventID)) { someEvent in
                NavigationButton(destination: EventDetailView(event: someEvent)) {
                    FeedRow(event: someEvent)
                }
            }
        }
            .navigationBarTitle(Text("Events"))
            .navigationBarHidden(false)
    }
}

//#if DEBUG
struct FeedView_Previews : PreviewProvider {
    static var previews: some View {
        FeedView(myEvents: eventData)
    }
}
//#endif
