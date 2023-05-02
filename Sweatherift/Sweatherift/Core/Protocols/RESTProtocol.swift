//
//  RESTProtocol.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/27/23.
//

import Foundation

protocol RESTProtocol {
   func get<T: Decodable>(url: String, returnType: T.Type) async -> Result<T, Error>
}
