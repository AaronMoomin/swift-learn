import SwiftUI

struct WeatherView: View {
    var body: some View {
        HStack {
            DayForecast(day: "Mon", weather:DayForecast.WeatherEnum.sun, max: 30,min: 28)
            
            DayForecast(day: "Thu", weather:DayForecast.WeatherEnum.rain, max: 30,min: 28)
        }
    }
}

struct DayForecast: View {
    let day: String
    let weather: WeatherEnum
    let max: Int
    let min: Int
    
    enum WeatherEnum {
        case sun
        case rain
    }
    
    struct ConfigStruct {
        let systemName: String
        let color: Color
    }
    
    var Config: ConfigStruct {
    
        switch weather {
        case .sun:
            return ConfigStruct(systemName:"sun.max.fill",color: Color.yellow)
        case .rain:
            return ConfigStruct(systemName: "cloud.rain.fill",color: Color.blue)
        }
    }
    
    var body: some View {
        VStack(spacing: 5) {
            Text(day)
                .font(.headline)
            Image(systemName: Config.systemName)
                .foregroundStyle(Config.color)
                .font(.largeTitle)
                .padding(5)
            Text("max: \(max)")
                .fontWeight(Font.Weight.semibold)
            Text("min: \(min)")
                .fontWeight(Font.Weight.medium)
                .foregroundStyle(Color.secondary)
        }
        .padding()
        
    }
}

#Preview {
    WeatherView()
}
