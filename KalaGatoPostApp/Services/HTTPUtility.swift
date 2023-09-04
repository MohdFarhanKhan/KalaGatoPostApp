//
//  HTTPUtility.swift
//  KalaGatoPostApp
//
//  Created by Najran Emarah on 17/02/1445 AH.
//

import Foundation

class HttpUtility
{
    static let shared = HttpUtility()
    private init(){}
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: T?)-> Void)
    {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                let decoder = JSONDecoder()
                do {
//                    if let jsonResponse = String(data: responseData!, encoding: String.Encoding.utf8) {
//                        print("JSON String: \(jsonResponse)")
//                    }
                    let result = try decoder.decode(T.self, from: responseData!)
                    _=completionHandler(result)
                }
                catch let error{
                    debugPrint("error occured while decoding = \(error)")
                }
            }

        }.resume()
    }

    
}
