//
//  GeocodeData.swift
//  GWeather
//
//  Created by Tomas Sanni on 10/4/22.
//

import Foundation

struct GeocodeData: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
}
