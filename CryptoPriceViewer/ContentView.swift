//
//  ContentView.swift
//  CryptoPriceViewer
//
//  Created by Karl McPhee on 11/27/23.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var cryptoViewModel : CryptoViewModel

    init() {
        self.cryptoViewModel = CryptoViewModel()
        
    }
    
    var body: some View {
        VStack {
            NavigationView{
                List(cryptoViewModel.crypto, id: \.uuid) { crypto in
                    VStack{
                        Text(crypto.name)
                            .font(.headline)
                            .foregroundColor(.green)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    VStack{
                        HStack {
                            
                            Text("Price: ")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("$"+String(Int(crypto.quote.usd.price)))
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                    }
                                 }
                }
            }
        }
        .padding()
        .task {
            await cryptoViewModel.downloadData(url:  URL(string: "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=c9cf1452-dccd-40df-9222-85c11ee3e278")!)
        }
    }
}

#Preview {
    ContentView()
}
