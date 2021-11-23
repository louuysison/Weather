//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Lou Allen Uy Sison on 11/22/21.
//

import Foundation

public class WeatherViewModel: ObservableObject {
    @Published var cityName: String = "City Name"
    @Published var temperature: Double = 0.0
    @Published var description: String = "--"
    @Published var weatherIcon: String = "c01d"
    @Published var dateToday: String = "2000-01-01"
    @Published var days: [DayEntry] = []
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    public func refresh() {
        weatherService.loadWeatherData { weather in
            DispatchQueue.main.async {
                self.cityName = weather.city
                self.temperature = weather.temperature
                self.description = weather.description.capitalized
                self.weatherIcon = weather.iconName
                self.dateToday = weather.dateToday
                self.days = weather.resp.data
            }
        }
    }
}
