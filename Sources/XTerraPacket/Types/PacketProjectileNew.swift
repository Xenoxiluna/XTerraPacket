//
//  PacketProjectileNew.swift
//
//
//  Created by Quentin Berry on 5/7/20.
// INCOMPLETE

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
    public var knockBack: Float32 = 0
    public var damage: Int16 = 0
    public var owner: UInt8 = 0
    public var type: Int16 = 0
    public var aiFlags: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.projectileId = try reader.readInt16()
        self.positionX = try reader.readFloat32()
        self.positionY = try reader.readFloat32()
        self.velocityX = try reader.readFloat32()
        self.velocityY = try reader.readFloat32()
        self.knockBack = try reader.readFloat32()
        self.damage = try reader.readInt16()
        self.owner = try reader.readUInt8()
        self.type = try reader.readInt16()
        self.aiFlags = try reader.readUInt8()
    }
    public func encoded() -> [UInt8]{
        print("Not Implemented")
        return []
    }
    mutating public func encode(){
        print("Not Implemented")
    }
    public func getLength(){
        print("Not Implemented")
    }
}
