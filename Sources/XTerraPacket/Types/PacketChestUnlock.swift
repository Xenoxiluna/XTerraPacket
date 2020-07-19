//
//  PacketChestUnlock.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

/// Chest Unlock(Used for doors as well)
public struct PacketChestUnlock: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .ChestUnlock
    public var payload: [UInt8] = []
    
    ///: 1 = Chest Unlock; 2 = Door Unlock
    public var chestType: UInt8 = 0
    public var x: Int16 = 0
    public var y: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.chestType = try reader.readUInt8()
        self.x = try reader.readInt16()
        self.y = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(chestType)
        try writer.writeInt16(x)
        try writer.writeInt16(y)
        payload.append(contentsOf: writer.data.bytes)
    }
}
