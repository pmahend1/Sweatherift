//
//  Repository.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation

extension Cache {
    func getCacheOrResult<T>(useCache: Bool = true,
                            forKey: Key,
                            returnType _: T.Type,
                            apiCall: @escaping () async -> Result<T, Error>) async -> Result<T, Error> where T: Decodable {
        if useCache {
            if let val = value(forKey: forKey), let valueUnwrapped = val as? T {
                return .success(valueUnwrapped)
            }
        }
        let result = await apiCall()
        return result
    }
}
