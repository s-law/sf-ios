//
//  EventDetailTextView.swift
//  Coffup
//
//  Created by Roderic Campbell on 6/10/19.
//

import SwiftUI

struct EventDetailTextViews : View {
    var event: WrappedEvent
    var body: some View {
        return HStack {
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.title)
                Text(event.venue.name)
                    .font(.subheadline)
                Text(event.startDate)
                    .font(.subheadline)
            }
            Spacer()
            }.padding(8)
    }
}


#if DEBUG
struct EventDetailTextView_Previews : PreviewProvider {
    static var previews: some View {
        EventDetailTextView()
    }
}
#endif
