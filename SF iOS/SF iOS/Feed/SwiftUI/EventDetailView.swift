//
//  EventDetailView.swift
//  Coffup
//
//  Created by Roderic Campbell on 6/10/19.
//

import SwiftUI

struct EventDetailView : View {
    var event: WrappedEvent
    
    var body: some View {
        VStack {
            MapView(coordinate: event.locationCoordinate)
            EventDetailTextViews(event: event)
            Spacer().frame(height: 10, alignment: .bottom)
            TransitButtonView()
            Spacer().frame(height: 40, alignment: .bottom)
        }.navigationBarTitle(Text(event.name),
                             displayMode: .inline)
    }
}

//#if DEBUG
struct EventDetailView_Previews : PreviewProvider {
    static var previews: some View {
        EventDetailView(event: eventData[0])
    }
}
//#endif
