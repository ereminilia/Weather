//
//  Model.swift
//  Weather
//
//  Created by Vitaliy Podolskiy on 09.11.2019.
//  Copyright © 2019 Vitaliy Podolskiy. All rights reserved.
//

import Foundation

struct Model: Codable {
    var coordinate: Coordinate
    var weather: [Weather]
    var main: Main
    var wind: Wind
    
    enum CodingKeys: String, CodingKey {
        case coordinate = "coord"
        case weather = "weather"
        case main, wind
    }
}

struct Coordinate: Codable {
    var longitude: Double
    var latitude: Double
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

struct Weather: Codable {
    var main: String
    var descriptionString: String
    
    enum CodingKeys: String, CodingKey {
        case main = "main"
        case descriptionString = "description"
    }
}

struct Main: Codable {
    var temp: Double
    var pressure: Int
    var humidity: Int
    var tempMin: Double
    var tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Wind: Codable {
    var speed: Double
    var deg: Double
}
