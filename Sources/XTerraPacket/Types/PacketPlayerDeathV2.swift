//
//  PacketPlayerDeathV2.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Client -> Server

import Foundation
import SwiftyBytes

/// Player Death version 2
public struct PacketPlayerDeathV2: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .PlayerDeathV2
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var playerDeathReason: UInt8 = 0
    public var fromPlayerIndex: Int16 = 0
    public var fromNpcIndex: Int16 = 0
    public var fromProjectileIndex: Int16 = 0
    public var fromOther: UInt8 = 0
    public var fromProjectileType: Int16 = 0
    public var fromItemType: Int16 = 0
    public var fromItemPrefix: UInt8 = 0
    public var fromCustomReason: String = ""
    public var damage: Int16 = 0
    public var hitDirection: UInt8 = 0
    public var flags: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        
        self.playerId = try reader.readUInt8()
        self.playerDeathReason = try reader.readUInt8()
        
        if (self.playerDeathReason.bits[0] != 0){
            self.fromPlayerIndex = try reader.readInt16()
        }
        if (self.playerDeathReason.bits[1] != 0){
            self.fromNpcIndex = try reader.readInt16()
        }
        if (self.playerDeathReason.bits[2] != 0){
            self.fromProjectileIndex = try reader.readInt16()
        }
        if (self.playerDeathReason.bits[3] != 0){
            self.fromOther = try reader.readUInt8()
        }
        if (self.playerDeathReason.bits[4] != 0){
            self.fromProjectileType = try reader.readInt16()
        }
        if (self.playerDeathReason.bits[5] != 0){
            self.fromItemType = try reader.readInt16()
        }
        if (self.playerDeathReason.bits[6] != 0){
            self.fromItemPrefix = try reader.readUInt8()
        }
        if (self.playerDeathReason.bits[7] != 0){
            self.fromCustomReason = try reader.readVariableLengthString(.utf8)
        }
        
        self.damage = try reader.readInt16()
        self.hitDirection = try reader.readUInt8()
        self.flags = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeUInt8(playerDeathReason)
        
        if (self.playerDeathReason.bits[0] != 0){
            try writer.writeInt16(fromPlayerIndex)
        }
        if (self.playerDeathReason.bits[1] != 0){
            try writer.writeInt16(fromNpcIndex)
        }
        if (self.playerDeathReason.bits[2] != 0){
            try writer.writeInt16(fromProjectileIndex)
        }
        if (self.playerDeathReason.bits[3] != 0){
            try writer.writeUInt8(fromOther)
        }
        if (self.playerDeathReason.bits[4] != 0){
            try writer.writeInt16(fromProjectileType)
        }
        if (self.playerDeathReason.bits[5] != 0){
            try writer.writeInt16(fromItemType)
        }
        if (self.playerDeathReason.bits[6] != 0){
            try writer.writeUInt8(fromItemPrefix)
        }
        if (self.playerDeathReason.bits[7] != 0){
            try writer.writeVariableLengthString(fromCustomReason, .utf8)
        }
        
        try writer.writeInt16(damage)
        try writer.writeUInt8(hitDirection)
        try writer.writeUInt8(flags)
        payload.append(contentsOf: writer.data.bytes)
    }
}
