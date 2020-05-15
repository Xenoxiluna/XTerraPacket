//
//  PacketDoorUse.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketDoorUse: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .DoorUse
    public var payload: [UInt8] = []
    public var action: UInt8 = 0
    public var tileX: Int16 = 0
    public var tileY: Int16 = 0
    public var direction: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.action = try reader.readUInt8()
        self.tileX = try reader.readInt16()
        self.tileY = try reader.readInt16()
        self.direction = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(action)
        try writer.writeInt16(tileX)
        try writer.writeInt16(tileY)
        try writer.writeUInt8(direction)
        payload.append(contentsOf: writer.data)
    }
}
