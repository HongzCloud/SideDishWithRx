//
//  NetworkError.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/02/27.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case networkConnection
    case responseNil
    case redirection
    case parsing
    case server
    case unknown
}
