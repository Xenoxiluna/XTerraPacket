//
//  PacketPlayerSpawn.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketPlayerSpawn: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ClientToServer
    public var packetType: TerrariaPacketType = .PlayerSpawn
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var spawnX: Int16 = 0
    public var spawnY: Int16 = 0
    public var respawnTimeRemaining: Int32 = 0
    public var reason: SpawnReason = .SpawningIntoWorld
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.spawnX = try reader.readInt16()
        self.spawnY = try reader.readInt16()
        self.respawnTimeRemaining = try reader.readInt32()
        if let r = SpawnReason.init(rawValue: try reader.readUInt8()){
            self.reason = r
        }
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeInt16(spawnX)
        try writer.writeInt16(spawnY)
        try writer.writeInt32(respawnTimeRemaining)
        try writer.writeUInt8(reason.rawValue)
        payload.append(contentsOf: writer.data.bytes)
    }
    
    public enum SpawnReason: UInt8{
        case ReviveFromDeath = 0
        case SpawningIntoWorld = 1
        case RecallFromItem = 2
    }
}
