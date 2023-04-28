//
//  Weather.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/28/23.
//

import Foundation

struct Weather: Identifiable, Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
