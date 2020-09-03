//
//  NetModuleCreativeUnlocksPlayerReport.swift
//  
//
//  Created by Quentin Berry on 7/16/20.
//

import Foundation
import SwiftyBytes

/// This is a struct for the CreativeUnlocksPlayerReport NetModule.
public struct NetModuleCreativeUnlocksPlayerReport: NetModule{
    public var zero: UInt8 = 0
    public var itemId: UInt16 = 0
    public var amount: UInt16 = 0

    public init(){}

    public init(zero: UInt8, itemId: UInt16, amount: UInt16){
        self.zero = zero
        self.itemId = itemId
        self.amount = amount
    }

    public mutating func decode(_ reader: BinaryReader, _ context: TerrariaPacketContext) throws{
        self.zero = try reader.readUInt8()
        self.itemId = try reader.readUInt16()
        self.amount = try reader.readUInt16()
    }
    public mutating func encode(_ writer: BinaryWriter, _ context: TerrariaPacketContext) throws{
        try writer.writeUInt8(self.zero)
        try writer.writeUInt16(self.itemId)
        try writer.writeUInt16(self.amount)
    }
}
