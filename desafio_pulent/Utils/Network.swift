//
//  Network.swift
//  desafio_pulent
//
//  Created by bild on 10/29/19.
//

import Foundation

class Network {
    
    func jsonRequest(param: String) -> ituneData? {
        
        var result: ituneData? = nil
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "https://itunes.apple.com/search?term=\(param)&mediaType=music")
        let request = URLRequest(url: url!)
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                return
            }
            
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            do {
                result = try decoder.decode(ituneData.self, from: data)
            } catch let catchError {
                print(catchError.localizedDescription)
            }
            
            semaphore.signal()
            
        }
        
        dataTask.resume()
        
        semaphore.wait()
        
        return result
    }
    
    func imageRequest(url: String) -> Data? {
        
        var result: Data? = nil
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: url)
        let request = URLRequest(url: url!)
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                return
            }
            
            guard let data = data else {
                return
            }
            
            result = data
            
            semaphore.signal()
            
        }
        
        dataTask.resume()
        
        semaphore.wait()
        
        return result
    }
    
    func albumRequest(id: Int) -> ituneData? {
        var result: ituneData? = nil
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "https://itunes.apple.com/lookup?id=\(id)&entity=song")
        let request = URLRequest(url: url!)
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            do {
                result = try decoder.decode(ituneData.self, from: data)
            } catch let catchError {
                print(catchError.localizedDescription)
            }
            
            semaphore.signal()
            
        }
        
        dataTask.resume()
        
        semaphore.wait()
        
        return result
    }
}
