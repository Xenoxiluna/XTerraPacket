//
//  PacketTreeGrowFX.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

/// Growth effects
public struct PacketTreeGrowFX: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .TreeGrowFX
    public var payload: [UInt8] = []
    
    /// 1 = Tree Growth  2 = Fairy
    public var growEffect: UInt8 = 0
    public var x: Int16 = 0
    public var y: Int16 = 0
    public var height: UInt8 = 0
    public var treeGore: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.growEffect = try reader.readUInt8()
        self.x = try reader.readInt16()
        self.y = try reader.readInt16()
        self.height = try reader.readUInt8()
        self.treeGore = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(growEffect)
        try writer.writeInt16(x)
        try writer.writeInt16(y)
        try writer.writeUInt8(height)
        try writer.writeInt16(treeGore)
        payload.append(contentsOf: writer.data.bytes)
    }
}
