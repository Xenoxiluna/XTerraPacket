//
//  PacketFoodPlatterTryPlacing.swift
//
//
//  Created by Quentin Berry on 5/22/20.
//  Direction: Client -> Server

import Foundation
import SwiftyBytes

/// Try placing food in a platter
public struct PacketFoodPlatterTryPlacing: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .FoodPlatterTryPlacing
    public var payload: [UInt8] = []
    public var x: Int16 = 0
    public var y: Int16 = 0
    public var netId: Int16 = 0
    public var prefix: UInt8 = 0
    public var stack: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.x = try reader.readInt16()
        self.y = try reader.readInt16()
        self.netId = try reader.readInt16()
        self.prefix = try reader.readUInt8()
        self.stack = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(x)
        try writer.writeInt16(y)
        try writer.writeInt16(netId)
        try writer.writeUInt8(prefix)
        try writer.writeInt16(stack)
        payload.append(contentsOf: writer.data.bytes)
    }
}
