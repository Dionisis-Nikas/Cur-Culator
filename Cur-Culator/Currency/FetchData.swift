//
//  FetchData.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 2/10/21.
//

import SwiftUI

@MainActor class FetchData: ObservableObject {

	@AppStorage("code") var code = "EUR"
	@AppStorage("convert") var currencySelection = "USD"
    @AppStorage("rate") var rate = 0.0
    @AppStorage("updateTime") var time = ""

	
	init() {

    }

    func getDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        return "\(hour)" + ":" + "\(minutes)"
        }
	
	func fetch() {
		
        let headers = [
            "x-rapidapi-host": "currency-exchange.p.rapidapi.com",
            "x-rapidapi-key": "f010a8ca5emsha322b3b80a02575p146eacjsn14c36ec80bec"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://currency-exchange.p.rapidapi.com/exchange?from=" + code + "&to=" + currencySelection + "&q=1.0")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error ?? "Error")
            } else {
                if let data = data {
                    let responseData = String(data: data, encoding: String.Encoding.utf8)
                    if let responseData = responseData {
                        DispatchQueue.main.async {
                            self.rate = (responseData as NSString).doubleValue
                            self.time = self.getDate()
                        }
                    }

                } else {
                    print("Error with response")
                }
            }
        })

        dataTask.resume()
	}
}


