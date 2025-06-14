import SwiftUI

@main
struct LoveAnniversaryApp: App {
    var body: some Scene {
        WindowGroup {
            TimerView()
        }
    }
}

struct TimerView: View {
    @State private var isCountdown = true
    @State private var now = Date()
    let calendar = Calendar.current
    
    let targetDate: Date = {
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.year = calendar.component(.year, from: Date())
        components.month = 12
        components.day = 7
        components.hour = 23
        components.minute = 30
        components.timeZone = TimeZone(identifier: "America/Los_Angeles")
        return calendar.date(from: components)!
    }()

    let startDate: Date = {
        var components = DateComponents()
        components.year = 2024
        components.month = 12
        components.day = 7
        components.hour = 23
        components.minute = 30
        components.timeZone = TimeZone(identifier: "America/Los_Angeles")
        return Calendar.current.date(from: components)!
    }()

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("Time Till Dating 💙Aniversary💜")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                let (months, weeks, days, hours, minutes, seconds, milliseconds, years) = timeComponents()

                Text("\(months) Months").font(.largeTitle).foregroundColor(.white)
                Text("\(weeks) Weeks").font(.title).foregroundColor(.white)
                Text("\(days) Days").font(.title).foregroundColor(.white)
                Text("\(hours) Hours").font(.title).foregroundColor(.white)
                Text("\(minutes) Minutes").font(.title).foregroundColor(.white)
                Text("\(seconds) Seconds").font(.title).foregroundColor(.white)
                Text("\(milliseconds) Milliseconds").font(.title).foregroundColor(.white)
                
                if !isCountdown {
                    Text("\(years) Years").font(.title2).foregroundColor(.white)
                }
                
                Button(action: {
                    isCountdown.toggle()
                }) {
                    Text(isCountdown ? "Switch to Stopwatch" : "Switch to Countdown")
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(8)
                }.padding(.top)

            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                self.now = Date()
            }
        }
    }

    func timeComponents() -> (Int, Int, Int, Int, Int, Int, Int, Int) {
        let target = isCountdown ? targetDate : startDate
        let diff = isCountdown ? target.timeIntervalSince(now) : now.timeIntervalSince(target)
        let absDiff = abs(diff)
        
        let months = Int(absDiff) / 2592000
        let weeks = Int(absDiff) / 604800
        let days = Int(absDiff) / 86400 % 7
        let hours = Int(absDiff) / 3600 % 24
        let minutes = Int(absDiff) / 60 % 60
        let seconds = Int(absDiff) % 60
        let milliseconds = Int((absDiff - floor(absDiff)) * 1000)
        let years = Int(absDiff) / 31536000
        return (months, weeks, days, hours, minutes, seconds, milliseconds, years)
    }
}
