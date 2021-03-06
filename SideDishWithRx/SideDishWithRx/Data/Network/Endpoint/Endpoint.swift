//
//  Endpoint.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/02/26.
//

import Foundation

struct Endpoint<R>: RequesteResponsable {

    typealias Response = R
    
    let baseURL = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan"
    let method: HTTPMethodType
    let path: String
    let isFullPath: Bool
    
    enum Path {
        case main
        case soup
        case side
        case detail(String)
        
        var rawValue: String {
            switch self {
            case .detail(let hash): return "/detail/\(hash)"
            default: return "/\(self)"
            }
        }
    }
    
    init(method: HTTPMethodType, path: Endpoint<RequesteResponsable>.Path) {
        self.method = method
        self.path = path.rawValue
        self.isFullPath = false
    }
    
    init(method: HTTPMethodType, fullPath: String) {
        self.method = method
        self.path = fullPath
        self.isFullPath = true
    }
}


