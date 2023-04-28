//
//  System.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/28/23.
//

import Foundation

struct System: Decodable, Identifiable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}
