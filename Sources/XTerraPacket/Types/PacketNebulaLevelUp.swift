//
//  PacketNebulaLevelUp.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

/// Nebula Level Up
public struct PacketNebulaLevelUp: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .NebulaLevelUp
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var levelUpType: UInt8 = 0
    public var originX: Float32 = 0
    public var originY: Float32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.levelUpType = try reader.readUInt8()
        self.originX = try reader.readFloat32()
        self.originY = try reader.readFloat32()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(levelUpType)
        try writer.writeFloat32(originX)
        try writer.writeFloat32(originY)
        payload.append(contentsOf: writer.data.bytes)
    }
}
