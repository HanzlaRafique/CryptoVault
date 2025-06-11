//
//  CoinChartView.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/26/24.
//

import SwiftUI

struct CoinChartView: View {
    
    @State private var percentage: CGFloat = 0.0
    private var graphData: [Double]
    private var maxValue: Double
    private var minValue: Double
    private var lineColor: Color
    private var startDate: Date
    private var lastDate: Date
   
    
    init(coinData: CoinsModel) {
        graphData = coinData.sparklineIn7D?.price ?? []
        maxValue = graphData.max() ?? 0.0
        minValue = graphData.min() ?? 0.0
        
        let priceChange = (graphData.last ?? 0) - (graphData.first ?? 0)
        lineColor = priceChange > 0 ? Color.green : Color.red
        
        lastDate = Date(coinGeckoString: coinData.lastUpdated ?? "")
        startDate = lastDate.addingTimeInterval(-7*24*60*60)
    }
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackLines)
                .overlay(alignment: .leading, content: {
                    chartBackLinesVal
                })
            setDate
        }
        .foregroundStyle(Color.thems.secondaryTxtColor)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.linear(duration: 5)) {
                    percentage = 1.0
                }
            }
        }
    }
}

#Preview {
    CoinChartView(coinData: DeveloperView.instance.coin)
}


extension CoinChartView {
    
    var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                
                for index in graphData.indices {
                    
                    let xPosition = geometry.size.width / CGFloat(graphData.count - 1) * CGFloat(index)

                    let yValueRange = maxValue - minValue
                    let yPosition = (1 - CGFloat((graphData[index] - minValue) / yValueRange)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    } else {
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(
                lineWidth: 2,
                lineCap: .round,
                lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10.0)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 20.0)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 30.0)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 40.0)
            
        }
    }
    
    var chartBackLines: some View {
        VStack {
            Divider()
                .frame(height: 2)
                .background(.green)
            Spacer()
            Divider()
                .frame(height: 2)
            Spacer()
            Divider()
                .frame(height: 2)
                .background(.red)
        }
    }
    
    var chartBackLinesVal: some View {
        VStack {
            Text(maxValue.formattedWithAbbreviations())
                .bold()
            Spacer()
            Text(((maxValue + minValue)/2).formattedWithAbbreviations())
                .bold()
            Spacer()
            Text(minValue.formattedWithAbbreviations())
                .bold()
        }
    }
    
    var setDate: some View {
        HStack {
            Text(startDate.asShortDateString())
            Spacer()
            Text(lastDate.asShortDateString())
        }
    }
    
}
