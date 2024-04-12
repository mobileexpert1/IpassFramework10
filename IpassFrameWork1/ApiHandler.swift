//
//  ApiHandler.swift
//  IpassFrameWork1
//
//  Created by Mobile on 10/04/24.
//

import Foundation


public class APIHandler {
    
    public static func LoginAuthAPi() {
        guard let apiURL = URL(string: "https://plusapi.ipass-mena.com/api/v1/ipass/create/authenticate/login") else { return }

        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "email": "ipassmobile@yopmail.com",
            "password": "Admin@123#"
        ]
        print("loginPostApi",apiURL)
        print("login parameters",parameters)
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print("Error serializing parameters: \(error.localizedDescription)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            let status = response.statusCode
            print("Response status code: \(status)")

            if status == 200 {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Response",json)
                        if let user = json["user"] as? [String: Any] {
                            if let email = user["email"] as? String, let token = user["token"] as? String {
                                UserLocalStore.shared.token = token
                                DispatchQueue.global().async {
                                createSessionAPI(token: token)
                                }
                                
                            } else {
                                print("Email or token not found in user dictionary")
                            }
                        } else {
                            print("User dictionary not found or is not of type [String: Any]")
                        }
                    } else {
                        print("Failed to parse JSON response")
                    }
                } catch let error {
                    print("Error parsing JSON response: \(error.localizedDescription)")
                }
            } else {
                print("Unexpected status code: \(status)")
            }
        }

        task.resume()
    }


       public static func createSessionAPI(token: String) {
           let urlString = "https://plusapi.ipass-mena.com/api/v1/ipass/plus/face/session/create?token=eyJhbGciOiJIUzI1NiJ9.aXBhc3Ntb2JpbGVAeW9wbWFpbC5jb21pcGFzcyBpcGFzcw.y66dMZJUkzYrRZoczlkNum8unLc910zIuGUVaQW5lUI"
    
           guard let apiURL = URL(string: urlString) else { return }
    
           // Prepare the request body
           let parameters: [String: Any] = [
               "email": "ipassmobile@yopmail.com",
               "auth_token": token
           ]
           print("sessionPostApi",apiURL)
           print("session parameters",parameters)
           
           guard let requestBody = try? JSONSerialization.data(withJSONObject: parameters) else {
               print("Failed to serialize parameters")
               return
           }
    
           var request = URLRequest(url: apiURL)
           request.httpMethod = "POST"
           request.httpBody = requestBody
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   print("Error: \(error.localizedDescription)")
                   return
               }
    
               guard let httpResponse = response as? HTTPURLResponse else {
                   print("Invalid response")
                   return
               }
    
               let statusCode = httpResponse.statusCode
               if statusCode == 200 {
                   if let responseData = data {
                       do {
                           let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: [])
                           print("Response:", jsonResponse)
//                           self.startCamera()
                          //sessionIdValue
                       } catch {
                           print("Failed to parse response:", error.localizedDescription)
                       }
                   } else {
                       print("Empty response data")
                   }
               } else {
                   print("HTTP status code: \(statusCode)")
                   if let responseData = data {
                       let responseString = String(data: responseData, encoding: .utf8)
                       print("Response:", responseString ?? "")
                   }
               }
           }
    
           task.resume()
       }
       
    
    
    
//    func faceMatchingApi(liveImage: String) {
//        guard let apiURL = URL(string: "https://ipassplus.csdevhub.com/api/v1/aws/face/maching") else {
//            return
//        }
//        
//        var parameters: [String: Any] = [:]
//
//        parameters["targetImageBase64"] = liveImage
//        
//        // Create JSON data from parameters
//        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
//            print("Error converting parameters to JSON")
//            return
//        }
//        
//        var request = URLRequest(url: apiURL)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = jsonData
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            DispatchQueue.main.async {
//                // Handle response
//                if let error = error {
//                    print("Error: \(error.localizedDescription)")
//
//                    return
//                }
//                
//                guard let httpResponse = response as? HTTPURLResponse else {
//                    print("Invalid response")
//
//                    return
//                }
//                
//                let statusCode = httpResponse.statusCode
//                print("Status code: \(statusCode)")
//                
//                if statusCode == 201 {
//                    if let responseData = data {
//                        do {
//                            if let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] {
//                                print("Response JSON: \(json)")
//                                
//                                if let data = json["data"] as? [String: Any],
//                                   let facePercentage = data["facePercentage"] as? Double {
//                                    print("facePercentage: \(facePercentage)")
//                                
//                                }
//                                
//
//                            }
//                        } catch {
//                            print("Error decoding JSON: \(error.localizedDescription)")
//
//                        }
//                    }
//                } else {
//                    print("Invalid status code: \(statusCode)")
//
//                }
//            }
//        }
//        
//        task.resume()
//    }

    
}

