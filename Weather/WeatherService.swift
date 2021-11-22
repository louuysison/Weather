//
//  WeatherService.swift
//  Weather
//
//  Created by Lou Allen Uy Sison on 11/22/21.
//

import Foundation
import CoreLocation

public final class WeatherService: NSObject {
    
    private let locationManager = CLLocationManager()
    private let API_KEY = "ca7e3d81ba3445809ac97854d6de14af"
    private var completionHandler: ((Weather) -> Void)?
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ completionHandler: @escaping((Weather) -> Void)) {
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // https://api.weatherbit.io/v2.0/forecast/daily?lat={lat}&lon={lon}&key={API_KEY}
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {

        guard let urlString =
                "https://api.weatherbit.io/v2.0/forecast/daily?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&key=\(API_KEY)"
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                print("\(error?.localizedDescription ?? "ERROR")")
                return
            }
            
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                self.completionHandler?(Weather(response: response))
            }
        }.resume()
    }
}

extension WeatherService: CLLocationManagerDelegate {
    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }
        print("GOT LOCATION")
        print(location.coordinate)
        makeDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Something went wrong: \(error.localizedDescription)")
    }
}
