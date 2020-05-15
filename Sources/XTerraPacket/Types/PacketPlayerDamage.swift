//
//  PacketPlayerDamage.swift
//  
//
//  Created by Quentin Berry on 5/10/20.
//

import Foundation
import SwiftyBytes

public struct PacketPlayerDamage: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .PlayerDamage
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var hitDirection: UInt8 = 0
    public var damage: Int16 = 0
    public var deathText: String = ""
    public var flags: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.hitDirection = try reader.readUInt8()
        self.damage = try reader.readInt16()
        self.deathText = try reader.read7BitEncodedString()
        self.flags = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeUInt8(hitDirection)
        try writer.writeInt16(damage)
        try writer.write7BitEncodedString(deathText, encoding: .utf8)
        try writer.writeUInt8(flags)
        payload.append(contentsOf: writer.data)
    }
}
