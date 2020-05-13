//
//  PacketWiredCannonShot.swift
//
//
//  Created by Quentin Berry on 5/10/20.
//

import Foundation
import SwiftyBytes

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
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.damage = try reader.readUInt16()
        self.knockback = try reader.readFloat32()
        self.x = try reader.readUInt16()
        self.y = try reader.readUInt16()
        self.angle = try reader.readUInt16()
        self.ammo = try reader.readUInt16()
        self.playerId = try reader.readUInt8()
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
