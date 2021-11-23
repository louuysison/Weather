// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let aPI = try API(json)

import Foundation

// MARK: - APIResponse
struct APIResponse: Decodable {
    let data: [DayEntry]
    let city_name, timezone: String
    let country_code, state_code: String
    let lon, lat: Double
}

// MARK: - DayEntry
struct DayEntry: Decodable, Identifiable {
    let moonrise_ts: Int
    let wind_cdir: String
    let rh: Int
    let pres, high_temp: Double
    let sunset_ts: Int
    let ozone, moon_phase, wind_gust_spd: Double
    let snow_depth, clouds, ts, sunrise_ts: Int
    let app_min_temp, wind_spd: Double
    let pop: Int
    let wind_cdir_full: String
    let slp, moon_phase_lunation: Double
    let valid_date: String
    let app_max_temp, vis, dewpt: Double
    let snow: Int
    let uv: Double
    let weather: WeatherInfo
    let wind_dir: Int
//    let max_dhi: String
    let clouds_hi: Int
    let precip, low_temp, max_temp: Double
    let moonset_ts: Int
    let datetime: String
    let temp, min_temp: Double
    let clouds_mid, clouds_low: Int
    var id: String { valid_date }
    // get date from String
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        let date = dateFormatter.date(from: datetime)
        return date!
    }
    // get dayOfWeek from date
    var dayOfWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        return dateFormatter.string(from: date)
    }
    // get sunrise time as String
    var sunriseString: String {
        let date = Date(timeIntervalSince1970: Double(sunrise_ts))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let string = dateFormatter.string(from: date)
        return string
    }
    // get sunset time as String
    var sunsetString: String {
        let date = Date(timeIntervalSince1970: Double(sunset_ts))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let string = dateFormatter.string(from: date)
        return string
    }
}

// MARK: - WeatherInfo
struct WeatherInfo: Decodable {
    let icon: String
    let code: Int
    let description: String
}
