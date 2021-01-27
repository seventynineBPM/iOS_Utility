//
//  Network.swift
//  iOS_Utility
//
//  Created by Joongsun Joo on 2020/02/14.
//  Copyright © 2020 Joongsun Joo. All rights reserved.
//

import UIKit
import Alamofire

class NetworkAlamofire {
    class func request(method: HTTPMethod,
                       api: String,
                       paramEncoding: ParameterEncoding,
                       header: [String:String]? = nil,
                       params: [String:Any]? = nil,
                       timeout: Int = 10,
                       completionHandler: @escaping (Bool, Any?) -> ()) {
        
//        var headers = Alamofire
        var headers = Alamofire.HTTPHeaders()
        header?.forEach({ (arg) in
            headers[arg.key] = arg.value
        })
        
        let manager = Alamofire.Session()
        manager.session.configuration.timeoutIntervalForRequest = TimeInterval(timeout)
        manager.request(api, method: method, parameters: params, encoding: paramEncoding, headers: headers).responseJSON { (response: AFDataResponse<Any>) in
            switch(response.result) {
            case.success(let data):
                if let dataDic = data as? [String:Any] {
                    if let errors = dataDic["errors"] as? [String: Any] {
                        if let code = errors["code"] as? String {
                            if (code == "E002") {
                                completionHandler(false, dataDic)
                                return
                            }
                        }
                    }
                    completionHandler(true, dataDic)
                    return
                } else {
                    if let data = data as? [[String: Any]] {
                        completionHandler(true, data)
                        return
                    }
                }
                break
            case .failure(let error):
                completionHandler(false, error)
                break
            }
        }
    }
}
