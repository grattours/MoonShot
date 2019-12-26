//
//  MissionView.swift
//  MoonShot
//
//  Created by Luc Derosne on 03/11/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    @State private var direction = Direction.down
    @State private var imageScale: CGFloat = 0.8
   
    enum Direction {
        case down, up
    }
    let mission: Mission
    let astronauts: [CrewMember]
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
    
    var body: some View {
        _ = mission
        return GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        //.frame(width: geometry.size.width * 0.7)
                        .frame(width: geometry.size.width * self.imageScale, height: geometry.size.height * self.imageScale)
                        .padding(.top)
                    
                    HStack {
                        if self.mission.launchDate != nil {
                            Text("Launch Date:")
                            Text("\(self.mission.formattedLaunchDate)")
                        }
                    }

                    Text(self.mission.description)
                        .padding()

                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule()  .stroke(Color.primary, lineWidth: 1))
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)

                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle()) // prevent NavigationLink from coloring image and name with tint colour
                    }
                    
                    Spacer(minLength: 25)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { drag in
                        withAnimation {
                            self.direction = drag.translation.height > 0 ? .up : .down
                            self.imageScale = self.direction == .up ? 0.80 : 0.20
                        }
                    }
            
            )
        }
        .navigationBarTitle(Text(mission.displayName),
                            displayMode: .inline)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions.first!,
                    astronauts: astronauts)
    }
}


//struct MissionView_Previews: PreviewProvider {
//    static let missions: [Mission] = Bundle.main.decode("missions.json")
//
//    static var previews: some View {
//        MissionView(mission: missions[0])
//    }
//}

//struct MissionView_Previews: PreviewProvider {
//    static var previews: some View {
//        MissionView()
//    }
//}
