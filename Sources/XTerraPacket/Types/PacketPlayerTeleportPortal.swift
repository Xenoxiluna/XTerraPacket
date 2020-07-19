//
//  PacketPlayerTeleportPortal.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client

import Foundation
import SwiftyBytes

/// Teleport player using portal
public struct PacketPlayerTeleportPortal: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .PlayerTeleportPortal
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var portalColorIndex: Int16 = 0
    public var newPositionX: Float32 = 0
    public var newPositionY: Float32 = 0
    public var velocityX: Float32 = 0
    public var velocityY: Float32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.portalColorIndex = try reader.readInt16()
        self.newPositionX = try reader.readFloat32()
        self.newPositionY = try reader.readFloat32()
        self.velocityX = try reader.readFloat32()
        self.velocityY = try reader.readFloat32()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeInt16(portalColorIndex)
        try writer.writeFloat32(newPositionX)
        try writer.writeFloat32(newPositionY)
        try writer.writeFloat32(velocityX)
        try writer.writeFloat32(velocityY)
        payload.append(contentsOf: writer.data.bytes)
    }
}
