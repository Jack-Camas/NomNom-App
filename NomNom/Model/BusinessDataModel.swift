//
//  BusinessDataModel.swift
//  nomnom
//
//  Created by Jack on 11/9/23.
//

import Foundation

struct BusinessData: Codable{
    var businesses:[Businesses]
}

struct Businesses:Codable {
    var name: String?
    var id   : String?
    var rating  : Float?
    var price  : String?
    var is_closed : Bool?
    var distance : Double?
    var image_url: String?
    var location: Location?
    var coordinates:Coordinates?
}
struct Coordinates: Codable{
    var latitude: Double?
    var longitude:Double?
}

struct Location: Codable{
    var display_address: [String]?
}



