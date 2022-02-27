//
//  Requestable.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/02/27.
//

import Foundation

protocol Requestable {
    var baseURL: String { get }
    var path: Endpoint<RequesteResponsable>.Path { get }
    var method: HTTPMethodType { get }
}

protocol RequesteResponsable: Requestable, Responsable {}

extension Requestable {
    func url() -> URL? {

        // baseURL + path
        let fullPath = "\(baseURL)\(path.rawValue)"
        guard let url = URL(string: fullPath) else { return nil }
        
        return url
    }
}

enum HTTPMethodType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
