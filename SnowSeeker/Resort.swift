//
//  Resort.swift
//  SnowSeeker
//
//  Created by Andres Marquez on 2021-09-08.
//

import SwiftUI

struct Resort: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    static let example = (Bundle.main.decode("resorts.json") as [Resort])[0]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
}

