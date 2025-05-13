//
//  ContentView.swift
//  BarChart
//
//  Created by Weerawut Chaiyasomboon on 13/05/2568.
//

import SwiftUI
import Charts

struct ContentView: View {
    let viewMonths: [ViewMonth] = [
        .init(date: Date.from(year: 2025, month: 1, day: 1), viewCount: 55000),
        .init(date: Date.from(year: 2025, month: 2, day: 1), viewCount: 65000),
        .init(date: Date.from(year: 2025, month: 3, day: 1), viewCount: 35000),
        .init(date: Date.from(year: 2025, month: 4, day: 1), viewCount: 70700),
        .init(date: Date.from(year: 2025, month: 5, day: 1), viewCount: 113400),
        .init(date: Date.from(year: 2025, month: 6, day: 1), viewCount: 50050),
        .init(date: Date.from(year: 2025, month: 7, day: 1), viewCount: 33000),
        .init(date: Date.from(year: 2025, month: 8, day: 1), viewCount: 89000),
        .init(date: Date.from(year: 2025, month: 9, day: 1), viewCount: 24210),
        .init(date: Date.from(year: 2025, month: 10, day: 1), viewCount: 42040),
        .init(date: Date.from(year: 2025, month: 11, day: 1), viewCount: 88000),
        .init(date: Date.from(year: 2025, month: 12, day: 1), viewCount: 11060)
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Youtube Views")
            
            Text("Total: \(viewMonths.reduce(0, {$0 + $1.viewCount}))")
                .foregroundStyle(.secondary)
            
            Chart {
                RuleMark(y: .value("Goals", 75000))
                    .foregroundStyle(.mint)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .annotation(alignment: .leading) {
                        Text("Goals")
                            .foregroundStyle(.secondary)
                            .font(.caption)
                    }
                
                ForEach(viewMonths) { viewMonth in
                    BarMark(
                        x: .value("Month", viewMonth.date, unit: .month),
                        y: .value(
                            "Views",
                            viewMonth.viewCount
                        )
                    )
                    .foregroundStyle(.pink.gradient)
                }
            }
            .frame(height: 180)
            .chartXAxis {
                AxisMarks(values: viewMonths.map { $0.date }) { date in
//                    AxisGridLine(centered: true)
//                    AxisTick(centered: true)
                    AxisValueLabel(format: .dateTime.month(.narrow))
                }
            }
            .chartYAxis {
//                AxisMarks(position: .leading)
                AxisMarks { mark in
                    AxisGridLine()
                    AxisValueLabel()
                }
            }
//            .chartYScale(domain: 0...200000)
//            .chartXAxis(.hidden)
//            .chartYAxis(.hidden)
//            .chartPlotStyle { plotContent in
//                plotContent
//                    .background(.mint.gradient.opacity(0.2))
//                    .border(.green, width: 1)
//            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct ViewMonth: Identifiable {
    let id = UUID()
    let date: Date
    let viewCount: Int
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}
