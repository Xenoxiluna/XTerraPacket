//
//  NetModuleCreativePowers.swift
//  
//
//  Created by Quentin Berry on 7/16/20.
//

import Foundation
import SwiftyBytes

/// This is a struct for the CreativePowers NetModule.
public struct NetModuleCreativePowers: NetModule{
    public var powerId: UInt16 = 0

    public init(){}

    public init(powerId: UInt16){
        self.powerId = powerId
    }

    public mutating func decode(_ reader: BinaryReader, _ context: TerrariaPacketContext) throws{
        self.powerId = try reader.readUInt16()
    }
    public mutating func encode(_ writer: BinaryWriter, _ context: TerrariaPacketContext) throws{
        try writer.writeUInt16(self.powerId)
    }
}
