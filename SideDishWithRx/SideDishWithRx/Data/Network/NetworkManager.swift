//
//  NetworkManager.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/02/26.
//

import Foundation
import RxSwift

protocol NetworkManager{
    func request<R: Decodable, E: RequesteResponsable>(endpoint: E) -> Observable<R> where E.Response == R
}

final class DefaultNetworkManager: NetworkManager {
    
    private let session: URLSessionable
    
    init(session: URLSessionable = URLSession.shared) {
        self.session = session
    }
    
    func request<R: Decodable, E: RequesteResponsable>(endpoint: E)  -> Observable<R> where E.Response == R {
        
        let url = endpoint.url()
        
        return Observable.create { emitter in
            guard let url = url else {
                emitter.onError(NetworkError.urlError)
                return Disposables.create()
            }
            
            let task = self.session.dataTask(with: url, completionHandler: { data, response, error in
                if response == nil { emitter.onError(NetworkError.networkConnection) }
                
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200..<300:
                        
                        if let data = data {
                            let decoder = JSONDecoder()
                            
                            do {
                                let decodedData = try decoder.decode(R.self, from: data)
                                
                                emitter.onNext(decodedData)
                                emitter.onCompleted()
                            } catch {
                                emitter.onError(NetworkError.parsing)
                            }
                        }
                        
                    case 300..<400:
                        emitter.onError(NetworkError.redirection)
                    case 400..<500:
                        emitter.onError(NetworkError.urlError)
                    case 500...:
                        emitter.onError(NetworkError.server)
                    default:
                        emitter.onError(NetworkError.unknown)
                    }
                }
            })
            
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
