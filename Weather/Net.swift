//
//  Net.swift
//  Weather
//
//  Created by Vitaliy Podolskiy on 09.11.2019.
//  Copyright © 2019 Vitaliy Podolskiy. All rights reserved.
//

import Foundation

class Net {
    
    func requestWeather(callback: @escaping (_ model: Model)->()) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        guard var url = URL(string: "https://api.openweathermap.org/data/2.5/weather") else {
            return
        }
        
        let urlParams = [
            "lat" : "\(FakeCoordinates.latitude)",
            "lon" : "\(FakeCoordinates.longitude)",
            "APPID": Keys.apiKey.rawValue
        ]
        
        url = url.appendingQueryParameters(urlParams)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(Model.self, from: data)
                DispatchQueue.main.async {
                    
                    callback(model)
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
//    func sendRequest() {
//        let sessionConfig = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
//
//        guard
//            var URL = URL(string: "https://api.openweathermap.org/data/2.5/weather") else {
//            return
//
//        }
//        let URLParams = [
//            "lat": "\(FakeCoordinates.latitude)",
//            "lon": "\(FakeCoordinates.longitude)",
//            "APPID": "2e9c81c99c39be499743d415b00b0797"
//        ]
//        URL = URL.appendingQueryParameters(URLParams)
//        var request = URLRequest(url: URL)
//        request.httpMethod = "GET"
//
//        let task = session.dataTask(with: request) { (data, response, error) in
//            print(response)
//        }
//        task.resume()
//        session.finishTasksAndInvalidate()
//
//    }
}


protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
    
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}

extension URL {
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
}



