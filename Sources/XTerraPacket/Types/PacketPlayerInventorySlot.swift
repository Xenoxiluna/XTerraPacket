//
//  PacketPlayerInventorySlot.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

/// Player Inventory Slot
public struct PacketPlayerInventorySlot: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .PlayerInventorySlot
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var slotId: Int16 = 0 // Updated from UInt8 for 1.4
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
        self.playerId = try reader.readUInt8()
        self.slotId = try reader.readInt16()
        self.stack = try reader.readInt16()
        self.prefix = try reader.readUInt8()
        self.itemNetId = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeInt16(slotId)
        try writer.writeInt16(stack)
        try writer.writeUInt8(prefix)
        try writer.writeInt16(itemNetId)
        payload.append(contentsOf: writer.data.bytes)
    }
}
