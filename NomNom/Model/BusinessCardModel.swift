//
//  BusinessCardModel.swift
//  nomnom
//
//  Created by Jack on 11/9/23.
//

import Foundation

struct BusinessCardModel: Codable,Equatable{
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
    static var favoritesKey: String {
        return "Favorites"
    }
    
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


extension BusinessCardModel {
    static func save(_ movies: [BusinessCardModel], forKey key: String) {
        let defaults = UserDefaults.standard
        let encodedData = try! JSONEncoder().encode(movies)
        defaults.set(encodedData, forKey: key)
    }

  
    static func getFood(forKey key: String) -> [BusinessCardModel] { 
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: key) {
            let decodedMovies = try! JSONDecoder().decode([BusinessCardModel].self, from: data)
            return decodedMovies
        } else {
            return []
        }
    }

    func addToFavorites() {
        
        var favoriteFood = BusinessCardModel.getFood(forKey: BusinessCardModel.favoritesKey)
        favoriteFood.append(self)
        BusinessCardModel.save(favoriteFood, forKey: BusinessCardModel.favoritesKey)
    }


    func removeFromFavorites() {
        var favoriteFood = BusinessCardModel.getFood(forKey: BusinessCardModel.favoritesKey)
        favoriteFood.removeAll { food in
            return self == food
        }
        
        BusinessCardModel.save(favoriteFood, forKey: BusinessCardModel.favoritesKey)
    }
}

