//
//  BusinessCardModel.swift
//  nomnom
//
//  Created by Jack on 11/9/23.
//

import Foundation

struct BusinessCardModel: Decodable{
    var id:String
    var name:String
    var rating:Float
    var favorite: Bool
    var price:String
    var open:Bool
    var address:[String]
    var urlImage: String
    var longitude:Double
    var latitude:Double
    
    var addessString: String {
         address.joined(separator: "\n")
    }
	
	init(business: Businesses) {
		self.id = business.id ?? "\(UUID())"
		self.name = business.name ?? "Coming Soon"
		self.rating = business.rating ?? 0.0
		self.favorite = false
		self.price = business.price ?? "unknown"
		self.open = business.is_closed  ?? true
		self.address = business.location?.display_address ?? []
		self.urlImage = business.image_url ?? ""
		self.longitude = business.coordinates?.longitude ?? 0.0
		self.latitude = business.coordinates?.latitude ?? 0.0
	}
}
