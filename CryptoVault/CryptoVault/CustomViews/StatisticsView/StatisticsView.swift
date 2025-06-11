//
//  StatisticsView.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/16/24.
//

import SwiftUI

struct StatisticsView: View {
    var statisticsModel: StatisticsModel
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(statisticsModel.title ?? "")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text(statisticsModel.value ?? "")
                .font(.headline)
                .foregroundStyle(.accent)
             
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption)
                    .rotationEffect(Angle(degrees: ((statisticsModel.percentage ?? 0) >= 0 ? 0 : 180)))
                
                Text((statisticsModel.percentage?.asNumberString() ?? "") + " %")
                   
            }
            .opacity(statisticsModel.percentage == nil ? 0 : 1)
            .foregroundColor((statisticsModel.percentage ?? 0) >= 0 ? .green : Color.red)
            
            
        }
        
    }
}

#Preview {
    StatisticsView(statisticsModel: DeveloperView.instance.statisticsModel)
}
