//
//  Header.swift
//  TeldaTask
//
//  Created by Taha Hussein on 28/11/2024.
//

import Alamofire

enum HeaderType {
    case normal
    case refreshToken
}

class HeadersRequest {
    static let shared = HeadersRequest()
    
    func getHeaders(type: HeaderType) -> [String: String] {
        var httpHeaders = [String: String]()
        
        if type == .normal {
            httpHeaders = [
                "Accept":"application/json",
                "Accept-Language":"en",
                "Content-Type":"application/json",
                "X-API-Key": "testing_key_READONLY"
          
            ]
        } else if type == .refreshToken {
            httpHeaders = [
                "Accept":"application/json",
                "Accept-Language":"en",
                "Content-Type":"application/json",
                "X-API-Key": "testing_key_READONLY"
            ]
        }
        
        return httpHeaders
    }
}
