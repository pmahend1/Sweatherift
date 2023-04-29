//
//  Wind.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/28/23.
//

import Foundation

struct Wind: Decodable {
   let speed: Double
   let deg: Int
   let gust: Double?
}
