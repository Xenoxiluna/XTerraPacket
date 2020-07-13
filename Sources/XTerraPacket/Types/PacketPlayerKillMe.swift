//
//  PacketPlayerKillMe.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketPlayerKillMe: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .PlayerKillMe
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var hitDirection: UInt8 = 0
    public var damage: Int16 = 0
    public var pvp: Bool = false
    public var deathText: String = ""
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.hitDirection = try reader.readUInt8()
        self.damage = try reader.readInt16()
        self.pvp = try reader.readBool()
        self.deathText = try reader.readVariableLengthString(.utf8)
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeUInt8(hitDirection)
        try writer.writeInt16(damage)
        try writer.writeBool(pvp)
        try writer.writeVariableLengthString(deathText, .utf8)
        payload.append(contentsOf: writer.data.bytes)
    }
}
