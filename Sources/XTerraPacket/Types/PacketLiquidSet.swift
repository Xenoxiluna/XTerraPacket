//
//  PacketLiquidSet.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

/// Set liquid
public struct PacketLiquidSet: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .LiquidSet
    public var payload: [UInt8] = []
    public var x: Int16 = 0
    public var y: Int16 = 0
    public var liquid: UInt8 = 0
    public var liquidType: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.x = try reader.readInt16()
        self.y = try reader.readInt16()
        self.liquid = try reader.readUInt8()
        self.liquidType = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(x)
        try writer.writeInt16(y)
        try writer.writeUInt8(liquid)
        try writer.writeUInt8(liquidType)
        payload.append(contentsOf: writer.data.bytes)
    }
}
