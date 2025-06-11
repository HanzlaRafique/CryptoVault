//
//  HomeStatisticsView.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/16/24.
//

import SwiftUI

struct HomeStatisticsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        
        HStack {
            
            ForEach(vm.statistics) { stat in
                
                StatisticsView(statisticsModel: stat)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading)
        
    }
}

#Preview {
    HomeStatisticsView(showPortfolio: .constant(false))
        .environmentObject(DeveloperView.instance.homeVM)
}
