//
//  Weather.swift
//  WeatherApp
//
//  Created by Tushar Sonawane on 07/09/20.
//  Copyright © 2020 Tushar Sonawane. All rights reserved.
//

struct CurrentWeather: Codable {
    let coord : Coord?
    let weather : [Weather]?
    let base : String?
    let main : Main?
    let visibility : Int?
    let wind : Wind?
    let clouds : Clouds?
    let dt : Int?
    let sys : Sys?
    let timezone : Int?
    let id : Int?
    let name : String?
    let cod : Int?
}
