//
//  PacketWiredCannonShot.swift
//
//
//  Created by Quentin Berry on 5/10/20.
//  Direction: Server -> Client

import Foundation
import SwiftyBytes

/// Wired cannon shot
public struct PacketWiredCannonShot: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .WiredCannonShot
    public var payload: [UInt8] = []
    public var damage: UInt16 = 0
    public var knockback: Float32 = 0
    public var x: UInt16 = 0
    public var y: UInt16 = 0
    public var angle: UInt16 = 0
    public var ammo: UInt16 = 0
    public var playerId: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.damage = try reader.readUInt16()
        self.knockback = try reader.readFloat32()
        self.x = try reader.readUInt16()
        self.y = try reader.readUInt16()
        self.angle = try reader.readUInt16()
        self.ammo = try reader.readUInt16()
        self.playerId = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt16(damage)
        try writer.writeFloat32(knockback)
        try writer.writeUInt16(x)
        try writer.writeUInt16(y)
        try writer.writeUInt16(angle)
        try writer.writeUInt16(ammo)
        try writer.writeUInt8(playerId)
        payload.append(contentsOf: writer.data.bytes)
    }
}
