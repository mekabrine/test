
import SwiftUI

struct ContentView: View {
    @State private var isCountdown = true
    @State private var now = Date()
    let targetDate: Date = {
        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents(calendar: calendar, timeZone: TimeZone(identifier: "America/Los_Angeles"),
                                        year: Calendar.current.component(.year, from: Date()),
                                        month: 12, day: 7, hour: 23, minute: 30)
        return calendar.date(from: components)!
    }()
    let startDate: Date = {
        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents(calendar: calendar, timeZone: TimeZone(identifier: "America/Los_Angeles"),
                                        year: 2024, month: 12, day: 7, hour: 23, minute: 30)
        return calendar.date(from: components)!
    }()

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Time Till Dating 💙Aniversary💜")
                    .font(.title)
                    .foregroundColor(.white)

                let diff = timeDifference(from: isCountdown ? now : startDate, to: isCountdown ? targetDate : now)
                Group {
                    TimeRow(label: "YRS", value: diff.years, highlight: true)
                    TimeRow(label: "MONTHS", value: diff.months)
                    TimeRow(label: "WEEKS", value: diff.weeks)
                    TimeRow(label: "DAYS", value: diff.days)
                    TimeRow(label: "HRS", value: diff.hours)
                    TimeRow(label: "MIN", value: diff.minutes)
                    TimeRow(label: "SEC", value: diff.seconds)
                    TimeRow(label: "MS", value: diff.milliseconds)
                }

                Button(action: { isCountdown.toggle() }) {
                    Text(isCountdown ? "Switch to Stopwatch" : "Switch to Countdown")
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                self.now = Date()
            }
        }
    }

    func timeDifference(from start: Date, to end: Date) -> (years: Int, months: Int, weeks: Int, days: Int, hours: Int, minutes: Int, seconds: Int, milliseconds: Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .weekOfMonth, .day, .hour, .minute, .second], from: start, to: end)
        let milliseconds = Int(end.timeIntervalSince(start) * 1000) % 1000
        return (
            years: components.year ?? 0,
            months: components.month ?? 0,
            weeks: components.weekOfMonth ?? 0,
            days: components.day ?? 0,
            hours: components.hour ?? 0,
            minutes: components.minute ?? 0,
            seconds: components.second ?? 0,
            milliseconds: milliseconds
        )
    }
}

struct TimeRow: View {
    var label: String
    var value: Int
    var highlight: Bool = false

    var body: some View {
        HStack {
            Text(String(format: "%02d", value))
                .font(.system(size: 64, weight: .bold))
                .foregroundColor(highlight ? .red : .white)
            Text(label)
                .font(.title2)
                .foregroundColor(highlight ? .red : .white)
        }
    }
}

#Preview {
    ContentView()
}
