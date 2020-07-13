//
//  PacketProjectileNew.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketProjectileNew: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .ProjectileNew
    public var payload: [UInt8] = []
    public var projectileId: Int16 = 0
    public var positionX: Float32 = 0
    public var positionY: Float32 = 0
    public var velocityX: Float32 = 0
    public var velocityY: Float32 = 0
    public var owner: UInt8 = 0
    public var type: Int16 = 0
    public var aiFlags: UInt8 = 0
    public var damage: Int16 = 0
    public var knockBack: Float32 = 0
    public var originalDamage: Int16 = 0
    public var projectileUUID: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.projectileId = try reader.readInt16()
        self.positionX = try reader.readFloat32()
        self.positionY = try reader.readFloat32()
        self.velocityX = try reader.readFloat32()
        self.velocityY = try reader.readFloat32()
        self.owner = try reader.readUInt8()
        self.type = try reader.readInt16()
        self.aiFlags = try reader.readUInt8()
        
        if aiFlags.bits[0] == 1{
            self.damage = try reader.readInt16()
        }
        if aiFlags.bits[1] == 1{
            self.knockBack = try reader.readFloat32()
        }
        if aiFlags.bits[2] == 1{
            self.originalDamage = try reader.readInt16()
        }
        if aiFlags.bits[3] == 1{
            self.projectileUUID = try reader.readInt16()
        }
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(projectileId)
        try writer.writeFloat32(positionX)
        try writer.writeFloat32(positionY)
        try writer.writeFloat32(velocityX)
        try writer.writeFloat32(velocityY)
        try writer.writeUInt8(owner)
        try writer.writeInt16(type)
        try writer.writeUInt8(aiFlags)
        
        if aiFlags.bits[0] == 1{
            try writer.writeInt16(damage)
        }
        if aiFlags.bits[1] == 1{
            try writer.writeFloat32(knockBack)
        }
        if aiFlags.bits[2] == 1{
            try writer.writeInt16(originalDamage)
        }
        if aiFlags.bits[3] == 1{
            try writer.writeInt16(projectileUUID)
        }
        payload.append(contentsOf: writer.data.bytes)
    }
}
