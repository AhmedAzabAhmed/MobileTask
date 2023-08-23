//
//  ScreenState.swift
//  MobileTask
//
//  Created by Ahmed Azab on 19/08/2023.
//

import Foundation

enum ScreenState<T> {
    case loading
    case success(T)
    case failure(APIErrors)
}
