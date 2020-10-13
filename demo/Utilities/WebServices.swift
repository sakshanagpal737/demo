//
//  WebServices.swift
//  eLearnEnglish
//
//  Created by Hitesh Grover on 17/12/18.
//  Copyright © 2018 Hitesh Grover. All rights reserved.
//

import Foundation
import Reachability



final class Webservices
{
    static let instance = Webservices()
    private init() {}
    
    // MARK: URLSession methods
    func getMethod(url:String,success: @escaping (_ isSuccess :Bool, _ response: [String:AnyObject]) -> Void)
    {
        if Common_Methods.isReachable()
        {
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "GET"
            request.timeoutInterval = 60
            request.cachePolicy = .reloadIgnoringLocalCacheData
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            if Common_Methods.accessUserDefaults(withKey: UserDefaultKeys.kToken) != nil
            {
                  request.setValue("Bearer "+Common_Methods.accessUserDefaults(withKey: UserDefaultKeys.kToken)!, forHTTPHeaderField: "Authorization")
            }
            
            // Create url session
            let session = URLSession(configuration: URLSessionConfiguration.default)
            // Call session data task.
            session.dataTask(with: request) { (data, response, error) -> Void in
                // Check Data
                if let data = data {
                    // Json Response
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    // response.
                    if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode
                    {
                        success(true,json as! [String:AnyObject])
                    }
                    else
                    {
                        DispatchQueue.main.async
                            {
                               // Common_Methods.showAlert(error?.localizedDescription ?? "session expired")
                                Common_Methods.showErrorAlert(error: .sessionExpired)
                            Common_Methods.callLoginScreenOnSessionExpire()
                          }
                       // success(true,json as! [String:AnyObject])
                    }
                } else {
                    DispatchQueue.main.async
                        {
                        Common_Methods.showErrorAlert(error: .networkError)
                            
                    }
                }
                }.resume()
        } else {
            DispatchQueue.main.async {
               Common_Methods.showErrorAlert(error: .noConnection)
            }
        }
    }
    
  
    func postMethod(_ urlString:String,param: [String:Any], completion: @escaping (_ isSuccess :Bool, _ response: AnyObject) -> Void)
    {
        if Common_Methods.isReachable()
        {
            guard let serviceUrl = URL(string: urlString) else { return }
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.timeoutInterval = 60
            request.cachePolicy = .reloadIgnoringLocalCacheData
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            if Common_Methods.accessUserDefaults(withKey: UserDefaultKeys.kToken) != nil
            {
                  request.setValue("Bearer "+Common_Methods.accessUserDefaults(withKey: UserDefaultKeys.kToken)!, forHTTPHeaderField: "Authorization")
            }
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else {
                return
            }
            request.httpBody = httpBody
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                // Check Data
                if let data = data {
                    // Json Response
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    // response.
                    if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                        completion(true,json as AnyObject)
                    } else {
                      //  completion(true,json as AnyObject)
                        DispatchQueue.main.async
                            {
                            Common_Methods.showErrorAlert(error: .sessionExpired)
                                 Common_Methods.callLoginScreenOnSessionExpire()
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        Common_Methods.showErrorAlert(error: .networkError)
                    }
                }
                }.resume()
        } else {
            DispatchQueue.main.async {
                Common_Methods.showErrorAlert(error: .noConnection)
            }
        }

    }

func putMethod(_ urlString:String,param: [String:Any], completion: @escaping (_ isSuccess :Bool, _ response: AnyObject) -> Void)
    {
        if Common_Methods.isReachable()
        {
            guard let serviceUrl = URL(string: urlString) else { return }
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "PUT"
            request.timeoutInterval = 60
            request.cachePolicy = .reloadIgnoringLocalCacheData
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else {
                return
            }
            request.httpBody = httpBody
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                // Check Data
                if let data = data {
                    // Json Response
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    // response.
                    if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                        completion(true,json as AnyObject)
                    } else {
                      //  completion(true,json as AnyObject)
                        DispatchQueue.main.async
                            {
                            Common_Methods.showErrorAlert(error: .sessionExpired)
                                 Common_Methods.callLoginScreenOnSessionExpire()
                                
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        Common_Methods.showErrorAlert(error: .networkError)
                    }
                }
                }.resume()
        } else {
            DispatchQueue.main.async {
                Common_Methods.showErrorAlert(error: .noConnection)
            }
        }

    }
    
    
    func uploadImageMethod(_ urlString:String,param: [String:String]?,imgData:Data,key:String, completion: @escaping (_ isSuccess :Bool, _ response: AnyObject) -> Void)
      {
          
          let boundary: String = "------VohpleBoundary4QuqLuM1cE5lMwCy"
          let contentType: String = "multipart/form-data; boundary=\(boundary)"
          
        let headers = [ "Authorization" : "\("Bearer \(Common_Methods.accessUserDefaults(withKey: UserDefaultKeys.kToken) ?? "")" )" ]
          
          var request = URLRequest(url: URL(string: urlString)!)
          
          for (key, value) in headers {
              request.setValue(value, forHTTPHeaderField: key)
          }
          
          request.httpShouldHandleCookies = false
          request.timeoutInterval = 600
          request.httpMethod = "POST"
          request.setValue(contentType, forHTTPHeaderField: "Content-Type")
          
          let body = NSMutableData()
          if let parameters = param {
              for (key, value) in parameters {
                  body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                  body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                  body.append("\(value)\r\n".data(using: String.Encoding.utf8)!)
              }
          }
          
              body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
              body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"image\(arc4random()).png\"\r\n".data(using: String.Encoding.utf8)!)
              body.append("Content-Type:image/png\r\n\r\n".data(using: String.Encoding.utf8)!)
            body.append(imgData)
            //  body.append(image.jpegData(compressionQuality: 0.4)!)
              body.append("\r\n".data(using: String.Encoding.utf8)!)
      
          
          body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
          request.httpBody = body as Data
        
         let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
                       // Check Data
        if let data = data {
                           // Json Response
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
                           // response.
        if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                completion(true,json as AnyObject)
            } else {
                //  completion(true,json as AnyObject)
                DispatchQueue.main.async
                {
                        Common_Methods.showErrorAlert(error: .sessionExpired)
                        Common_Methods.callLoginScreenOnSessionExpire()
                }
            }
        } else {
            DispatchQueue.main.async {
            Common_Methods.showErrorAlert(error: .networkError)
                           }
                       }
                       }.resume()
      }
}
