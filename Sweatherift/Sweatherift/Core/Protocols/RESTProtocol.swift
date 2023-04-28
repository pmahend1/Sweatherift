//
//  RESTProtocol.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/27/23.
//

import Foundation

protocol RESTProtocol {
    func get(url: String) async -> Result<Data, Error>
}
