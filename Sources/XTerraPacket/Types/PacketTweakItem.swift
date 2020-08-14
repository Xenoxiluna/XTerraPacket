//
//  PacketTweakItem.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server -> Client

import Foundation
import SwiftyBytes

/// Tweak item
public struct PacketTweakItem: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .TweakItem
    public var payload: [UInt8] = []
    public var itemIndex: Int16 = 0
    
    /// Flags: 1 = Color; 2 = Damage; 4 = Knockback; 8 = UseAnimation; 16 = UseTime; 32 = Shoot; 64 = ShootSpeed; 128 = NextFlags
    public var flags1: UInt8 = 0
    
    /// If Flags1 Color on
    public var packedColorValue: UInt32 = 0
    
    // if Flags1 Damage on
    public var damage: UInt16 = 0
    
    /// if Flags1 Knockback on
    public var knockback: Float32 = 0
    
    /// if Flags1 UseAnimation on
    public var useAnimation: UInt16 = 0
    
    /// if Flags1 UseTime on
    public var useTime: UInt16 = 0
    
    /// if Flags1 Shoot on
    public var shoot: Int16 = 0
    
    /// if Flags1 ShootSpeed on
    public var shootSpeed: Float32 = 0
    
    /// if Flags1 NextFlags on;  Flags: 1 = Width; 2 = Height; 4 = Scale; 8 = Ammo; 16 = UseAmmo; 32 = NotAmmo
    public var flags2: UInt8 = 0
    
    /// if Flags2 Width on
    public var width: Int16 = 0
    
    /// if Flags2 Height on
    public var height: Int16 = 0
    
    /// if Flags2 Scale on
    public var scale: Float32 = 0
    
    /// If Flags2 Ammo on
    public var ammo: Int16 = 0
    
    /// If Flags2 UseAmmo on
    public var useAmmo: Int16 = 0
    
    /// If Flags2 NotAmmo on
    public var notAmmo: Bool = false
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        
        self.itemIndex = try reader.readInt16()
        self.flags1 = try reader.readUInt8()
        if (self.flags1.bits[0] == 1){
            self.packedColorValue = try reader.readUInt32()
        }
        if (self.flags1.bits[1] == 1){
            self.damage = try reader.readUInt16()
        }
        if (self.flags1.bits[2] == 1){
            self.knockback = try reader.readFloat32()
        }
        if (self.flags1.bits[3] == 1){
            self.useAnimation = try reader.readUInt16()
        }
        if (self.flags1.bits[4] == 1){
            self.useTime = try reader.readUInt16()
        }
        if (self.flags1.bits[5] == 1){
            self.shoot = try reader.readInt16()
        }
        if (self.flags1.bits[6] == 1){
            self.shootSpeed = try reader.readFloat32()
        }

        if (self.flags1.bits[7] == 1){
            self.flags2 = try reader.readUInt8()
            if (self.flags1.bits[0] == 1){
                self.width = try reader.readInt16()
            }
            if (self.flags1.bits[1] == 1){
                self.height = try reader.readInt16()
            }
            if (self.flags1.bits[2] == 1){
                self.scale = try reader.readFloat32()
            }
            if (self.flags1.bits[3] == 1){
                self.ammo = try reader.readInt16()
            }
            if (self.flags1.bits[4] == 1){
                self.useAmmo = try reader.readInt16()
            }
            if (self.flags1.bits[5] == 1){
                self.notAmmo = try reader.readBool()
            }
        }
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(itemIndex)
        try writer.writeUInt8(flags1)
        if (self.flags1.bits[0] == 1){
            try writer.writeUInt32(packedColorValue)
        }
        if (self.flags1.bits[1] == 1){
            try writer.writeUInt16(damage)
        }
        if (self.flags1.bits[2] == 1){
            try writer.writeFloat32(knockback)
        }
        if (self.flags1.bits[3] == 1){
            try writer.writeUInt16(useAnimation)
        }
        if (self.flags1.bits[4] == 1){
            try writer.writeUInt16(useTime)
        }
        if (self.flags1.bits[5] == 1){
            try writer.writeInt16(shoot)
        }
        if (self.flags1.bits[6] == 1){
            try writer.writeFloat32(shootSpeed)
        }

        if (self.flags1.bits[7] == 1){
            try writer.writeUInt8(flags2)
            if (self.flags1.bits[0] == 1){
                try writer.writeInt16(width)
            }
            if (self.flags1.bits[1] == 1){
                try writer.writeInt16(height)
            }
            if (self.flags1.bits[2] == 1){
                try writer.writeFloat32(scale)
            }
            if (self.flags1.bits[3] == 1){
                try writer.writeInt16(ammo)
            }
            if (self.flags1.bits[4] == 1){
                try writer.writeInt16(useAmmo)
            }
            if (self.flags1.bits[5] == 1){
                try writer.writeBool(notAmmo)
            }
        }
        payload.append(contentsOf: writer.data.bytes)
    }
}
