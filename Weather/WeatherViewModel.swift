//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Lou Allen Uy Sison on 11/22/21.
//

import Foundation

public class WeatherViewModel: ObservableObject {
    @Published var cityName: String = "City Name"
    @Published var temperature: String = "--"
    @Published var description: String = "--"
    @Published var weatherIcon: String = "sun.max.fill"
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    public func refresh() {
        weatherService.loadWeatherData { weather in
            DispatchQueue.main.async {
                self.cityName = weather.city
                self.temperature = "\(weather.temperature)°C"
                self.description = weather.description.capitalized
                self.weatherIcon = weather.iconName
            }
        }
    }
}
