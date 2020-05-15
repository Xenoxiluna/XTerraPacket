//
//  PacketNpcShopItem.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketNpcShopItem: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .NpcShopItem
    public var payload: [UInt8] = []
    public var slot: UInt8 = 0
    public var itemType: Int16 = 0
    public var stack: Int16 = 0
    public var prefix: UInt8 = 0
    public var value: Int32 = 0
    public var flags: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.slot = try reader.readUInt8()
        self.itemType = try reader.readInt16()
        self.stack = try reader.readInt16()
        self.prefix = try reader.readUInt8()
        self.value = try reader.readInt32()
        self.flags = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(slot)
        try writer.writeInt16(itemType)
        try writer.writeInt16(stack)
        try writer.writeUInt8(prefix)
        try writer.writeInt32(value)
        try writer.writeUInt8(flags)
        payload.append(contentsOf: writer.data)
    }
}
