//
//  NetModuleBestiary.swift
//  
//
//  Created by Quentin Berry on 7/16/20.
//

import Foundation
import SwiftyBytes

/// INCOMPLETE
public struct NetModuleBestiary: NetModule{
    public var type: BestiaryType = .Chat

    public init(){}

    public mutating func decode(_ reader: BinaryReader) throws{
        if let t = BestiaryType.init(rawValue: try reader.readUInt8()){
            self.type = t
        }
    }
    public mutating func encode(_ writer: BinaryWriter) throws{
        
    }
    
    public enum BestiaryType: UInt8{
        case KillCount = 0
        case Sight = 1
        case Chat = 2
    }
}
