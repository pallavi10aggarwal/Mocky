//
//  MockyResponse.swift
//  MockyEntersekt
//
//  Created by Pallavi Aggarwal on 5/26/22.
//

import Foundation

struct MockyResponse: Codable {
    let floors: [MockyResponseDataResult]
}
struct MockyResponseData: Codable {
    let floors: [MockyResponseDataResult]
}

struct MockyResponseDataResult: Codable {
    let id: Int
    let name: String
    let rooms: [RoomsData]?
    init(id: Int,
         name: String,
         rooms: [RoomsData]
         ) {
        self.id = id
        self.name = name
        self.rooms = rooms
    }
}
struct RoomsData: Codable {
    let id: Int
    let name: String
    let availability: [AvailabilityData]?
    init(id: Int,
         name: String,
         availability: [AvailabilityData]
         ) {
        self.id = id
        self.name = name
        self.availability = availability
    }
}
struct AvailabilityData: Codable {
    let id: Int
    let timeslot: String
    init(id: Int,
         timeslot: String
         ) {
        self.id = id
        self.timeslot = timeslot
    }
}

