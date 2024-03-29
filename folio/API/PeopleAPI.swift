//
//  Person.swift
//  folio
//
//  Created by Mats Daniel Larsen on 30/10/2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper
import CoreData


struct People: Mappable {
    var results: [Person]?
    var info: Info?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        results <- map["results"]
        info <- map["info"]
    }
    
}

struct Person: Mappable {
    var gender: String?
    var name: Name?
    var location: Location?
    var email: String?
    var dateOfBirth: DateOfBirth?
    var phone: String?
    var id: ID?
    var picture: Picture?
    var nationality: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        gender <- map["gender"]
        name <- map["name"]
        location <- map["location"]
        email <- map["email"]
        dateOfBirth <- map["dob"]
        phone <- map["phone"]
        id <- map["id"]
        picture <- map["picture"]
        nationality <- map["nat"]
    }
}

struct Name: Mappable {
    var title: String?
    var first: String?
    var last: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        first <- map["first"]
        last <- map["last"]
    }
}

struct Location: Mappable {
    var street: String?
    var city: String?
    var state: String?
    var postcode: String?
    var coordinates: Coordinates?
    var timezone: Timezone?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        street <- map["street"]
        city <- map["city"]
        state <- map["state"]
        postcode <- map["postcode"]
        coordinates <- map["coordinates"]
        timezone <- map["timezone"]
    }
}

    struct Coordinates: Mappable {
        var longitude: Double?
        var latitude: Double?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            var latitude: String?
            var  longitude: String?
            latitude <- map["latitude"]
            longitude <- map["longitude"]

            if let latitude = latitude {
                self.latitude = Double(latitude)
            }
            if let longitude = longitude {
                self.longitude = Double(longitude)
            }
        }
    }

    struct Timezone: Mappable {
        var offset: String?
        var description: String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            offset <- map["offset"]
            description <- map["description"]
        }
    }

struct DateOfBirth: Mappable {
    var date: Date?
    var age: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        date <- (map["date"], DateTransform())
        age <- map["age"]
    }
}

struct ID: Mappable {
    var name: String?
    var value: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        value <- map["value"]
    }
}

struct Picture: Mappable {
    var large: String?
    var medium: String?
    var thumbnail: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        large <- map["large"]
        medium <- map["medium"]
        thumbnail <- map["thumbnail"]
    }
}

struct Info: Mappable {
    var seed: String?
    var results: Int?
    var version: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        seed <- map["seed"]
        results <- map["results"]
        version <- map["version"]
    }
}

class PeopleAPI: ObservableObject {
    
    @Published var data: People?
    
    var seed = AppStorage.getSeed()
    
    init() {
        fetch()
    }
    
    func refresh() async {
        fetch()
    }
    
    func fetch() {
        print(self.seed)
        
        let url = "https://randomuser.me/api/?seed=\(self.seed)&results=100&nat=no"
        
        AF.request(url,
           method: .get,
           parameters: nil,
           encoding: URLEncoding.default,
           headers: nil
        ).validate().responseJSON { response in
            switch response.result {
                case .success(let value):
                    self.data = Mapper<People>().map(JSONObject: value)
                
                case .failure(let error):
                    print(error)
            }
        }
    }
}
