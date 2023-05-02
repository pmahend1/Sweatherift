//
//  InjectionKey.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation

public protocol InjectionKey {
   associatedtype Value
   static var currentValue: Self.Value { get set }
}
