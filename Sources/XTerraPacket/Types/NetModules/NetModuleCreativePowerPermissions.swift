//
//  NetModuleCreativePowerPermissions.swift
//  
//
//  Created by Quentin Berry on 7/16/20.
//

import Foundation
import SwiftyBytes

/// This is a struct for the CreativePowerPermissions NetModule.
public struct NetModuleCreativePowerPermissions: NetModule{
    public var zero: UInt8 = 0
    public var powerId: UInt16 = 0
    public var level: UInt8 = 0

    public init(){}

    public init(zero: UInt8, powerId: UInt16, level: UInt8){
        self.zero = zero
        self.powerId = powerId
        self.level = level
    }

    public mutating func decode(_ reader: BinaryReader) throws{
        self.zero = try reader.readUInt8()
        self.powerId = try reader.readUInt16()
        self.level = try reader.readUInt8()
    }
    public mutating func encode(_ writer: BinaryWriter) throws{
        try writer.writeUInt8(self.zero)
        try writer.writeUInt16(self.powerId)
        try writer.writeUInt8(self.level)
    }
}
