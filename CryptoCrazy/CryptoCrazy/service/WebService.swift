//
//  WebService.swift
//  CryptoCrazy
//
//  Created by beyyzgur on 27.08.2025.
//

import Foundation

enum CryptoError: Error {
    case serverError
    case parseError
}

class WebService {
    
    func downloadCurrencies(url: URL, completion: @escaping (Result<[CryptoModel], CryptoError>) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                return completion(.failure(.serverError))
            }
            guard let data = data else {
                return completion(.failure(.serverError))
            }
            
            do {
                let cryptoList = try JSONDecoder().decode([CryptoModel].self, from: data)
                completion(.success(cryptoList))
            } catch {
                completion(.failure(.parseError))
            }
            
        }.resume()
    }
    
}
