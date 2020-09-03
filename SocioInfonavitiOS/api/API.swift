//
//  API.swift
//  SocioInfonavitiOS
//
//  Created by pepe on 02/09/20.
//  Copyright © 2020 pepeMalpica. All rights reserved.
//

import Foundation



class API {
    
    static let shared: API = API()
    let BASE_URL = "https://staging.api.socioinfonavit.io/api/v1/"
    
    private init(){ }
    
    func makegetCall<T: Codable>( endPoint: String, completionHandler: @escaping (Result<T, Error>) -> Void  ){
        guard let url = URL(string: BASE_URL+endPoint) else {
            print("Error: cannot create URL")
            return
        }
        var getrequest = URLRequest(url: url)
        LocalStorageManager.shared.getJWT { (jwt) in
            getrequest.addValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        }
        getrequest.httpMethod = "GET"
        getrequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: getrequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling GET")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            do {
                // Decode
                let jsonDecoder = JSONDecoder()
                let responseObj = try jsonDecoder.decode(T.self, from: responseData)
                DispatchQueue.main.async {
                  completionHandler(.success(responseObj))
                }
            } catch let err  {
                print("error parsing response from GET")
                print("\(err)")
                DispatchQueue.main.async {
                  completionHandler(.failure(err))
                }
                
                return
            }
            
        }
        task.resume()
    }
    
    func makePostCall<T: Codable>( endPoint: String, parameters: String, completionHandler: @escaping (Result<T, Error>) -> Void ) {
        guard let url = URL(string: BASE_URL+endPoint) else {
            print("Error: cannot create URL")
            return
        }
        var postRequest = URLRequest(url: url)
        postRequest.httpMethod = "POST"
        postRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        postRequest.httpBody = parameters.data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: postRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on /todos/1")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            if let httpUrlResponse = response as? HTTPURLResponse
            {
                if (error != nil) {
                    print("Error Occurred: \(error!.localizedDescription)")
                } else {
                    if let token = httpUrlResponse.allHeaderFields["Authorization"] as? String {
                        let JWT = token.replacingOccurrences(of: "Bearer ", with: "")
                        print("\(JWT)")
                        LocalStorageManager.shared.saveJWT(jwt:JWT)
                    }
                    
                }
            }
            
            do {
                // Decode
                let jsonDecoder = JSONDecoder()
                let responseObj = try jsonDecoder.decode(T.self, from: responseData)
                DispatchQueue.main.async {
                  completionHandler(.success(responseObj))
                }
            } catch let err  {
                print("error parsing response from POST")
                print("\(err)")
                DispatchQueue.main.async {
                  completionHandler(.failure(err))
                }
                
                return
            }
            
        }
        task.resume()
    }
    
    
}
