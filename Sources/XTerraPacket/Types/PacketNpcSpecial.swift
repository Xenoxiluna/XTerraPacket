//
//  PacketNpcSpecial.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

/// Special NPC Effect
public struct PacketNpcSpecial: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .NpcSpecial
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    
    /// 1 = Spawn Skeletron; 2 = Invoke sound at player; 3 = Start Sundialing (if server is receiving); 4 = SpawnSmoke
    public var effectType: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.effectType = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeUInt8(effectType)
        payload.append(contentsOf: writer.data.bytes)
    }
}
