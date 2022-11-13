//
//  FetchData.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 2/10/21.
//

import SwiftUI

@MainActor class FetchData: ObservableObject {

    @AppStorage("rate") var rate = 0.0
    @AppStorage("updateTime") var time = ""

	
	init() {

    }

    func getDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let result = dateFormatter.string(from: date)
        return result
        }
	
    func fetch(withBase: String, withTarget: String, completion: @escaping () -> Void?, errorHandler: @escaping () -> Void?) {
		
        let headers = [
            "x-rapidapi-host": "currency-exchange.p.rapidapi.com",
            "x-rapidapi-key": "f010a8ca5emsha322b3b80a02575p146eacjsn14c36ec80bec"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://currency-exchange.p.rapidapi.com/exchange?from=" + withBase + "&to=" + withTarget + "&q=1.0")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error ?? "Error")
                errorHandler()
            } else {
                if let data = data {
                    let responseData = String(data: data, encoding: String.Encoding.utf8)
                    if let responseData = responseData {
                        DispatchQueue.main.async {
                            self.rate = (responseData as NSString).doubleValue
                            self.time = self.getDate()

                        }
                        completion()
                    }

                } else {
                    print("Error with response")
                    errorHandler()
                }
            }
        })

        dataTask.resume()
	}
}


