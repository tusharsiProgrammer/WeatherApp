//
//  WindViewModel.swift
//  WeatherApp
//
//  Created by Tushar Sonawane on 07/09/20.
//  Copyright © 2020 Tushar Sonawane. All rights reserved.
//

import Foundation

struct WindViewModel {

    let currentWeather: CurrentWeather
    private(set) var coordString = ""
    private(set) var windSpeedString = ""
    private(set) var windDegString = ""
    private(set) var locationString = ""

    init(currentWeather: CurrentWeather) {
        self.currentWeather = currentWeather
        updateProperties()
    }

    private mutating func updateProperties() {
        coordString = setCoordString(currentWeather: currentWeather)
        windSpeedString = setWindSpeedString(currentWeather: currentWeather)
        windDegString = setWindDirectionString(currentWeather: currentWeather)
        locationString = setLocationString(currentWeather: currentWeather)
    }

}

extension WindViewModel {
    
    private func setCoordString(currentWeather: CurrentWeather) -> String {
        return "Lat: \(currentWeather.coord?.lat ?? 0.0), Lon: \(currentWeather.coord?.lon ?? 0.0)"
    }

    private func setWindSpeedString(currentWeather: CurrentWeather) -> String {
        return "Wind Speed: \(currentWeather.wind?.speed ?? 0.0)"
    }

    private func setWindDirectionString(currentWeather: CurrentWeather) -> String {
        return "Wind Deg: \(currentWeather.wind?.deg ?? 0)"
    }

    private func setLocationString(currentWeather: CurrentWeather) -> String {
        return "Location: \(currentWeather.name ?? "")"
    }
}
