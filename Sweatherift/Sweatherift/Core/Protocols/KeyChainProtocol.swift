//
//  KeyChainProtocol.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 5/9/23.
//

import Foundation

protocol KeyChainProtocol {
   func save<T>(_ item: T, service: String, account: String) where T: Codable
   func read<T>(service: String, account: String, type: T.Type) -> T? where T: Codable
   func delete(service: String, account: String)
}
