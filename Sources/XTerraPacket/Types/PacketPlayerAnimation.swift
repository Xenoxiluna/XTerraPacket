//
//  PacketPlayerAnimation.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

/// Player item animation
public struct PacketPlayerAnimation: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .PlayerAnimation
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var itemRotation: Float32 = 0
    public var itemAnimation: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.itemRotation = try reader.readFloat32()
        self.itemAnimation = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeFloat32(itemRotation)
        try writer.writeInt16(itemAnimation)
        payload.append(contentsOf: writer.data.bytes)
    }
}
