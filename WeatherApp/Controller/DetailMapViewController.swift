//
//  DetailMapViewController.swift
//  WeatherApp
//
//  Created by Tushar Sonawane on 07/09/20.
//  Copyright © 2020 Tushar Sonawane. All rights reserved.
//

import UIKit
import CoreLocation

class DetailMapViewController: UIViewController {

    private let apiManager = APIManager()
    private(set) var windViewModel: WindViewModel?
    var pushCoordinate: Coord?
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var coordLabel: UILabel!

    var searchResult: CurrentWeather? {
        didSet {
            guard let searchResult = searchResult else { return }
            windViewModel = WindViewModel.init(currentWeather: searchResult)
            DispatchQueue.main.async {
                self.updateLabels()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeather()
    }
    
}

extension DetailMapViewController {

    private func updateLabels() {
        guard let windViewModel = windViewModel else { return }
        locationLabel.text = windViewModel.locationString
        windSpeedLabel.text = windViewModel.windSpeedString
        windDirectionLabel.text = windViewModel.windDegString
        coordLabel.text = windViewModel.coordString
    }

    private func getWeather() {
        apiManager.getWeather(lat: pushCoordinate?.lat ?? 0.0, lon: pushCoordinate?.lon ?? 0.0) { (weather, error) in
            if let error = error {
                print("Get weather error: \(error.localizedDescription)")
                return
            }
            guard let weather = weather  else { return }
            self.searchResult = weather
            print("Current Weather Object:")
            print(weather)
        }
    }
}
