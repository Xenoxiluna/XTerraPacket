//
//  File.swift
//  
//
//  Created by Quentin Berry on 5/26/20.
//

import Foundation

extension UInt8 {
    var bits: [UInt8] {
        var result : [UInt8] = []
        var mask = UInt8(0b10000000)
        for i in 0..<8 {
            result.append((self >> i) & 1)
        }
        return result
    }
}
