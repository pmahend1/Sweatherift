//
//  KeyChainProtocol.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 5/9/23.
//

import Foundation

protocol KeyChainProtocol {
   var keyValues: [String: Codable] { get set }
   func save<T>(_ item: T, key: String) where T: Codable
   func read<T>(key: String, type: T.Type) -> T? where T: Codable
   func delete(key: String)
}
