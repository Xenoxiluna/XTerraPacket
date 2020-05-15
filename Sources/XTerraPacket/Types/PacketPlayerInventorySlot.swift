//
//  PacketPlayerInventorySlot.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

/// Payload Structure
/// Offset  |  Type  |  Description
///   1        UInt8    playerId
///   2        UInt8    slot
///   3-4     UInt16  stack
///   5        UInt8    prefix
///   6-7     UInt16  itemId
///
/// ----------------------------------
public struct PacketPlayerInventorySlot: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .PlayerInventorySlot
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var slotId: UInt8 = 0
    public var stack: Int16 = 0
    public var prefix: UInt8 = 0
    public var itemNetId: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.slotId = try reader.readUInt8()
        self.stack = try reader.readInt16()
        self.prefix = try reader.readUInt8()
        self.itemNetId = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeUInt8(slotId)
        try writer.writeInt16(stack)
        try writer.writeUInt8(prefix)
        try writer.writeInt16(itemNetId)
        payload.append(contentsOf: writer.data)
    }
}
