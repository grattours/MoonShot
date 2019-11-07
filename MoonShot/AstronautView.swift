//
//  AstronautView.swift
//  MoonShot
//
//  Created by Luc Derosne on 06/11/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let astronaut: Astronaut
    
    var body: some View {
        let astronautMissions: [Mission] = missions.filter { mission in
            mission.crew.contains(where: { $0.name == self.astronaut.id })
        }
        
        return GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width:geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1) // to fix SwiftUI bug causing text to be truncated for some astronauts on some devices
                    
                    VStack(alignment: .leading) {
                        Text("Missions:")
                        List(astronautMissions, id: \.id) {
                            Text("\($0.displayName)")
                        }
                    }
                }
                
            }
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronaughts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronaughts[0])
    }
}
