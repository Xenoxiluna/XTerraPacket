//
//  PacketNpcStrike.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

/// NPC Attack
public struct PacketNpcStrike: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .NpcItemStrike
    public var payload: [UInt8] = []
    public var npcId: Int16 = 0
    public var damage: Int16 = 0
    public var knockback: Float32 = 0
    public var direction: UInt8 = 0
    public var crit: Bool = false
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.npcId = try reader.readInt16()
        self.damage = try reader.readInt16()
        self.knockback = try reader.readFloat32()
        self.direction = try reader.readUInt8()
        self.crit = try reader.readBool()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(npcId)
        try writer.writeInt16(damage)
        try writer.writeFloat32(knockback)
        try writer.writeUInt8(direction)
        try writer.writeBool(crit)
        payload.append(contentsOf: writer.data.bytes)
    }
}
