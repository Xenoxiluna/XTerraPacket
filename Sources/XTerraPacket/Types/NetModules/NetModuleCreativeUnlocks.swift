//
//  NetModuleCreativeUnlocks.swift
//  
//
//  Created by Quentin Berry on 7/16/20.
//

import Foundation
import SwiftyBytes

/// This is a struct for the CreativeUnlockst NetModule.
public struct NetModuleCreativeUnlocks: NetModule{
    public var itemId: Int16 = 0
    public var sacrificeCount: UInt16 = 0

    public init(){}

    public init(itemId: Int16, sacrificeCount: UInt16){
        self.itemId = itemId
        self.sacrificeCount = sacrificeCount
    }

    public mutating func decode(_ reader: BinaryReader, _ context: TerrariaPacketContext) throws{
        self.itemId = try reader.readInt16()
        self.sacrificeCount = try reader.readUInt16()
    }
    public mutating func encode(_ writer: BinaryWriter, _ context: TerrariaPacketContext) throws{
        try writer.writeInt16(self.itemId)
        try writer.writeUInt16(self.sacrificeCount)
    }
}
