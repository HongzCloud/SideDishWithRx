//
//  NetworkSessionManager.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/02/27.
//

import Foundation

protocol URLSessionable {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionable  {}
