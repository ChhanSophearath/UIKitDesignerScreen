//
//  ApiManager.swift
//  IQ
//
//  Created by Rath! on 30/1/24.
//

import Foundation


enum HTTPMethod: String {
    case POST = "POST"
    case GET = "GET"
    case PUT = "PUT"
    case DELETE = "DELETE"
    case PATCH = "PATCH"
}

public typealias Parameters = [String: Any]


class ApiManager{
    
    // singleton partern
    static let shared = ApiManager() // shareinstance
    public typealias success = (_ response: Data) -> Void
    public typealias HTTPHeaders = [String: String]

    public var isLoading: Bool = true
    
    func getHeader()-> HTTPHeaders {
        
        let language =  "" // Localize.currentLanguage()
        var languageValue:String = ""

        switch language {
        case "km-KH":
            languageValue = "km"
        case "en":
            languageValue = "en"
        case "zh-Hant":
            languageValue = "zh"
        default:
            languageValue = "en"
        }
        
        var headers: HTTPHeaders
        let token: String? = nil //UserDefaults.standard.string(forKey: AppConstants.token)
        
        if token != "" && token != nil{
            headers = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token!)",
                "Accept-Language" : languageValue
            ]
        }else{
            headers = [
                "Content-Type": "application/json",
                "Accept-Language" : languageValue
            ]
        }
        
        print("Beare \(token!)")

        return headers
    }
    
    
    func apiConnection(url: URL, method: HTTPMethod, param: Parameters?, headers: HTTPHeaders?, res: @escaping success) {
        
        let request: NSMutableURLRequest = NSMutableURLRequest()
        request.url = url
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        // add headers
        if headers == nil {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } else {
            if let header = headers {
                for (key, value) in header {
                    request.setValue(value, forHTTPHeaderField: key)
                }
            }
        }
        
        // add parameters
        do {
            if let param = param {
                request.httpBody = try JSONSerialization.data(withJSONObject: param , options:[])
            }
        } catch let error as NSError {
            print("error", error.localizedDescription)
        }
        
        if Reachability.isConnectedToNetwork(){
//            if isLoading{
                Loading.shared.showLoading()
//            }
            
           
            URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                
                print( "url ==> " ,url )
                
                if let httpResponse = response as? HTTPURLResponse {
                    if (200...299).contains(httpResponse.statusCode) {
                        
                        res(data!)
                        
//                        DispatchQueue.main.async {
//                            Loading.shared.hideLoading()
//                        }
                        
//                        self.isLoading = true
                    } else if  httpResponse.statusCode ==  401 {
                        
//                        self.refreshToken { response in
//                        
//                            Validator.validateModel(model: LoginModel(), data: response, fun: "refreshToken") { result in
//                                if result.response?.status == 200{
//                                    
//                                    UserDefaults.standard.set(result.results?.refreshToken, forKey: AppConstants.refreshToken)
//                                    UserDefaults.standard.set(result.results?.token, forKey: AppConstants.token)
//                                    
//                                    DispatchQueue.main.async {
//                                        
//                                        self.apiConnection(url: url, method: method, param: param, headers: ["Authorization" : "Bearer " + (result.results?.token ?? "")]) { response in
//                                            res(response)
//                                        }
//                                    }
//                                   
//                                }else{
//                                    DispatchQueue.main.async {
//                                        Loading.shared.hideLoading()
//                                        AlertMessage.shared.showAlertLogout(title: nil, message: nil)
//                                    }
//                                }
//                            }
//                        }
                        
//                        self.isLoading = true
                    }else{
                        
//                        print("error_code: \(httpResponse.statusCode)")
                        self.mapingError(data: data!)
//                        self.isLoading = true
                    }
                }else{
//                    Loading.shared.hideLoading()
                    AlertMessage.shared.showAlert(message: "Internal server error.")
//                    self.isLoading = true
                }
            }).resume()
           
        }else{
//            Loading.shared.hideLoading()
            AlertMessage.shared.showAlert(message: "Internet is not connected.")
            
        }
    }
    
    func mapingError(data: Data){
        print("error_data: \(data.toJSON() as Any)")
        Validator.validateModel(model: ErrorModel().self, data: data, fun: "") { (res) in
            DispatchQueue.main.async {
                AlertMessage.shared.showAlert(message: (res.error ?? res.message) ?? "")
            }
        }
    }
    
    func sendCodeOTP(param: Parameters, success: @escaping success) {
        let url = URL(string: ""/* ApiKey.baseUrl + ApiEndPoint.sendCode*/)
        
        print("url: \(url!)")
        
        apiConnection(url: url!,
                      method: .POST,
                      param: param,
                      headers: nil,
                      res: success)
    }
    
}

