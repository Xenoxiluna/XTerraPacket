//
//  PacketTeleport.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

/// Player teleport (INCOMPLETE)
public struct PacketTeleport: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .Teleport
    public var payload: [UInt8] = []
    
    /// Flags: 0 = Player Teleport; 1 = NPC Teleport; 2 = Player Teleport to another player; 4 = GetPositionFromTarget; 8 = HasExtraInfo
    public var flags: UInt8 = 0
    public var targetId: Int16 = 0
    public var x: Float32 = 0
    public var y: Float32 = 0
    public var style: UInt8 = 0
    public var extraInfo: Int32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.flags = try reader.readUInt8()
        self.targetId = try reader.readInt16()
        self.x = try reader.readFloat32()
        self.y = try reader.readFloat32()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(flags)
        try writer.writeInt16(targetId)
        try writer.writeFloat32(x)
        try writer.writeFloat32(y)
        payload.append(contentsOf: writer.data.bytes)
    }
}
