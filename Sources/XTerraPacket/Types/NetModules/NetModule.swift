//
//  NetModule.swift
//  
//
//  Created by Quentin Berry on 7/15/20.
//

import Foundation
import SwiftyBytes

public protocol NetModule{
    mutating func decode(_ reader: BinaryReader) throws
    mutating func encode(_ writer: BinaryWriter) throws
    
    init()
}
