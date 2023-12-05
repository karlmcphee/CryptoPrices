//
//  CryptoViewModel.swift
//  CryptoPriceViewer
//
//  Created by Karl McPhee on 11/10/23.
//

import Foundation

class CryptoViewModel: ObservableObject
{
    @Published var crypto = [Datum]()
    
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
                fatalError("Couldn't find file 'Info.plist'")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_Key") as? String else {
                fatalError("Couldn't find key 'API_KEY' in 'Info.plist")
            }
            return value
        }
    }
    let service = APIConnectionService()
    
    func downloadData(url: URL) async {
        do {
            let url2 = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=\(apiKey)"
            let cryptos = try await service.downloadDataAsync(url:  URL(string: url2)!)
            DispatchQueue.main.async {
                let prelist = cryptos.data
                self.crypto = prelist
            }
        } catch {
            print(error)
        }
        
    }
}
