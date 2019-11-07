//
//  Mission.swift
//  MoonShot
//
//  Created by Luc Derosne on 02/11/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation

//struct CrewRole: Codable {
//    let name: String
//    let role: String
//}




struct Mission: Codable, Identifiable {
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }

    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }

    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    //let launchDate: String?
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
}


