//
//  PacketChestItem.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketChestItem: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .ChestItem
    public var payload: [UInt8] = []
    public var chestId: Int16 = 0
    public var itemSlot: UInt8 = 0
    public var stack: Int16 = 0
    public var prefix: UInt8 = 0
    public var itemNetId: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.chestId = try reader.readInt16()
        self.itemSlot = try reader.readUInt8()
        self.stack = try reader.readInt16()
        self.prefix = try reader.readUInt8()
        self.itemNetId = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(chestId)
        try writer.writeUInt8(itemSlot)
        try writer.writeInt16(stack)
        try writer.writeUInt8(prefix)
        try writer.writeInt16(itemNetId)
        payload.append(contentsOf: writer.data.bytes)
    }
}
