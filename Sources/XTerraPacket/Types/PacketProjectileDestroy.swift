//
//  PacketProjectileDestroy.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

/// Destroy a projectile
public struct PacketProjectileDestroy: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .ProjectileDestroy
    public var payload: [UInt8] = []
    public var projectileId: Int16 = 0
    public var owner: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.projectileId = try reader.readInt16()
        self.owner = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(projectileId)
        try writer.writeUInt8(owner)
        payload.append(contentsOf: writer.data.bytes)
    }
}
