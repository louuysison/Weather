//
//  WeatherView.swift
//  Weather
//
//  Created by Lou Allen Uy Sison on 11/21/21.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    @State private var selectedIndex = 0
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                
                // if viewModal data is loaded, show UI, else show ProgressView
                if viewModel.days.count > 0 {
                    ScrollView(.vertical, showsIndicators: false) {
                        WhiteTextWithPadding(text: viewModel.cityName)
                        
                        let selectedDay = viewModel.days[selectedIndex]
                        
                        WhiteTextWithPadding(text: selectedDay.valid_date)
                        
                        MainWeatherStatusView(imageName: selectedDay.weather.icon,
                                              description: selectedDay.weather.description,
                                              temperature: selectedDay.temp)
                        
                        AdditionalInfoView(selectedDay: selectedDay)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 30) {
                                ForEach(0..<10, id: \.self) { index in
                                    Button {
                                        selectedIndex = index
                                    } label: {
                                        WeatherDayView(dayOfWeek: viewModel.days[index].dayOfWeek,
                                                       imageName: viewModel.days[index].weather.icon,
                                                       temperature: viewModel.days[index].temp
                                        )
                                    }.frame(height: 180)
                                }
                            }.padding(.leading, 15)
                        }.frame(height: 200)
                    }
                } else {
                    ProgressView()
                }
            }.onAppear(perform: viewModel.refresh)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Double
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            Text(String(format: "%.1f°C", temperature))
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.blue, Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

struct WhiteTextWithPadding: View {
    
    var text: String
    var size: CGFloat = 32
    
    var body: some View {
        Text(text)
            .font(.system(size: size, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct AdditionalInfoView: View {
    
    var selectedDay: DayEntry
    
    var body: some View {
        HStack {
            VStack {
                AdditionalInfoTextView(label: "Min. Temp", value: String(format: "%.1f°C", selectedDay.min_temp))
                AdditionalInfoTextView(label: "Sunrise", value: selectedDay.sunriseString)
                AdditionalInfoTextView(label: "Chance of rain", value: "\(selectedDay.pop)%")
            }
            .padding(10)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 1))
            Spacer()
            VStack {
                AdditionalInfoTextView(label: "Max. Temp", value: String(format: "%.1f°C", selectedDay.max_temp))
                AdditionalInfoTextView(label: "Sunset", value: selectedDay.sunsetString)
                AdditionalInfoTextView(label: "Amount", value: String(format: "%.4f mm", selectedDay.precip))
            }
            .padding(10)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 1))
        }.padding(10)
    }
}

struct AdditionalInfoTextView: View {
    
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text("\(label):")
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
        }.padding(.bottom, 5)
    }
}

struct MainWeatherStatusView: View {
    
    var imageName: String
    var description: String
    var temperature: Double
    
    var body: some View {
        VStack(spacing: 8) {
            Image(imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text(description)
                .font(.system(size: 32, weight: .medium))
                .foregroundColor(.white)
            
            Text(String(format: "%.1f°C", temperature))
                .font(.system(size: 50, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}
