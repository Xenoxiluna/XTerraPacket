//
//  PacketChestUnlock.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketChestUnlock: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .ChestUnlock
    public var payload: [UInt8] = []
    public var chestType: UInt8 = 0
    public var x: Int16 = 0
    public var y: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
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
        payload.append(contentsOf: writer.data)
    }
}
