//
//  PacketEffectMana.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

/// Mana regen effect
public struct PacketEffectMana: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .EffectMana
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var manaAmount: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.manaAmount = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeInt16(manaAmount)
        payload.append(contentsOf: writer.data.bytes)
    }
}
