//
//  APIEndpoints.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/02/27.
//

import Foundation

struct APIEndpoints {
    
    static func getDishes(path: Endpoint<RequesteResponsable>.Path) -> Endpoint<Dishes> {
        return Endpoint<Dishes>(method: .get, path: path)
    }
    
    static func getDetailDish(hash: String) -> Endpoint<DetailDish> {
        return Endpoint<DetailDish>(method: .get, path: .detail(hash))
    }
    
    static func getDishImage(fullPath: String) -> Endpoint<Void> {
        return Endpoint<Void>(method: .get, fullPath: fullPath)
    }
}
