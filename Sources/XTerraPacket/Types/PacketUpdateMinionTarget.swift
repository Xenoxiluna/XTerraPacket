//
//  PacketUpdateMinionTarget.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

/// Update minion target
public struct PacketUpdateMinionTarget: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .UpdateMinionTarget
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var targetX: Float32 = 0
    public var targetY: Float32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.targetX = try reader.readFloat32()
        self.targetY = try reader.readFloat32()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeFloat32(targetX)
        try writer.writeFloat32(targetY)
        payload.append(contentsOf: writer.data.bytes)
    }
}
