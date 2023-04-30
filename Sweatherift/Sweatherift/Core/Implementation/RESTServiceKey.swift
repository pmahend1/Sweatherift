//
//  RESTServiceKey.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation

struct RESTServiceKey: InjectionKey {
   static var currentValue: RESTProtocol = RESTService()
}
