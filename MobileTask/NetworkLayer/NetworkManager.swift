//
//  NetworkManager.swift
//  MobileTask
//
//  Created by Ahmed Azab on 19/08/2023.
//

import Foundation

import Moya
import Foundation

class NetworkManager {
    
    private init() {}
    static let shared = NetworkManager()
    
    func call<T: Codable, Target: TargetType>(provider: MoyaProvider<Target>,
                                              target: Target,
                                              model: T.Type?) async throws -> T {
        
        let result = await execute(provider: provider,
                                   target: target,
                                   model: model)
        switch result {
        case .success(let value):
            do {
                let dataModel = try JSONDecoder().decode(T.self, from: value.data)
                return dataModel
                
            } catch {
                throw APIConstants.Errors.parseError
            }
        case .failure(_):
            throw APIConstants.Errors.genericError
        }
        
    }
    
    
    private func execute<T: Codable, Target: TargetType>(provider: MoyaProvider<Target>,
                                                         target: Target,
                                                         model: T.Type?) async ->  Result<Response, MoyaError> {
        
        return await withCheckedContinuation({ continuation in
            provider.request(target) { result in
                continuation.resume(returning: result)
            }
        })
    }
}
