//
//  ImageRepository.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/13.
//

import Foundation
import RxSwift
import RxCocoa

final class ImageRepository {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
    }
    
    func load(from fullPath: String) -> Observable<Data> {
        let endpoint = APIEndpoints.getDishImage(fullPath: fullPath)

        return  networkManager.request(endpoint: endpoint)
    }
}
