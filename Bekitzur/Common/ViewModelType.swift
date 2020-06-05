//
//  ViewModelType.swift
//  Bekitzur
//
//  Created by Maks Niagolov on 2020/06/05.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
