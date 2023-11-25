//
//  BusinessNetworking.swift
//  nomnom
//
//  Created by Jack on 11/9/23.
//

import UIKit
import CoreLocation

enum BSError: Error {
	case clientError
	case serverError
	case decodeError
	case dataError
	case invalidUrl
}

class BusinessManagment {
	
	static let shared = BusinessManagment()
	
	let baseURL = "https://api.yelp.com/v3/businesses/search"
	let apikey = "WY4lMzv9JU2f7uS8DEORj7aMG-3XLOHTXVR1tk1ZPqvY6Mehp5QjSInLLUNn-bit9226-LPmZAxDTk6iHka8uLTEvlk2M3tfgna6_s0kl1k-WnR3Ifo5_ZRNd1uTY3Yx"
	
	func fetchData(latitude: CLLocationDegrees,
				   longitude: CLLocationDegrees,
				   category: String,
				   limit: Int,
				   sortBy: String,
				   locale: String,
				   completion: @escaping (Result<[BusinessCardModel],BSError>) -> Void) {
		
		let businessURL = "\(baseURL)?latitude=\(latitude)&longitude=\(longitude)&categories=\(category)&limit=\(limit)&sort_by=\(sortBy)&locale=\(locale)"
		//        let businessURL = 	"\(baseURL)?latitude=\(latitude)&longitude=\(longitude)&categories=\		(category)"
		
		//performRequest(businessURL:businessURL)
		performRequest(businessURL: businessURL, completion: completion)
		
	}
	
	func performRequest(businessURL:String, completion: @escaping (Result<[BusinessCardModel],BSError>) -> Void ){
		guard let url = URL(string: businessURL) else {
			completion(.failure(.invalidUrl))
			return
		}
		
		var request = URLRequest(url: url)
		request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
		request.httpMethod = "GET"
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let _ = error {
				completion(.failure(.clientError))
				return
			}
			
			guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
				completion(.failure(.serverError))
				return
			}
			
			guard let data = data else {
				completion(.failure(.dataError))
				return
			}
			
			do {
				let data = try JSONDecoder().decode(BusinessData.self, from: data)
				//print(data)
				let cardData = data.businesses.map { 
                    
                     
                    BusinessCardModel(business: $0)
				}
                
                
				completion(.success(cardData))
			} catch {
				completion(.failure(.dataError))
			}
		}
		task.resume()
	}
}



/////
/////do {
//
///// Read data as JSON
//let json = try JSONSerialization.jsonObject(with: data!, options: [])
//
///// Main dictionary
//guard let resp = json as? NSDictionary else { return }
//
///// Businesses
//guard let businesses = resp.value(forKey: "businesses") as? [NSDictionary] else { return }
//
//var venuesList: [BusinessData] = []
//
///// Accessing each business
//for business in businesses {
//    var venue = BusinessData()
//    venue.name = business.value(forKey: "name") as? String
//    venue.id = business.value(forKey: "id") as? String
//    venue.rating = business.value(forKey: "rating") as? Float
//    venue.price = business.value(forKey: "price") as? String
//    venue.is_closed = business.value(forKey: "is_closed") as? Bool
//    venue.distance = business.value(forKey: "distance") as? Double
//    venue.latitude = business.value(forKey: "latitude") as? Double
//
//    let address = business.value(forKeyPath: "location.display_address") as? [String]
//    venue.address = address?.joined(separator: "\n")
//
//    venuesList.append(venue)
//}
//
//
//
//} catch {
//print("Caught error")
//
//}
//}.resume()
