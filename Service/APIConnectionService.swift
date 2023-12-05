//
//  APIConnectionService.swift
//  CryptoPriceViewer
//
//  Created by Karl McPhee on 11/27/23.
//

import Foundation


class APIConnectionService {
    
    func downloadDataAsync(url: URL) async throws -> CryptoModel {
        let (data, _) = try await URLSession.shared.data(from: url)
        let stocks = try JSONDecoder().decode(CryptoModel.self, from: data)
        print(stocks)
        return stocks
    }
}
