//
//  PacketSpawnBossorInvasion.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Client -> Server

import Foundation
import SwiftyBytes

/// Spawns boss or invasion
public struct PacketSpawnBossorInvasion: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .SpawnBossorInvasion
    public var payload: [UInt8] = []
    public var playerId: Int16 = 0
    
    /**
     -1 = GoblinInvasion
     -2 = FrostInvasion
     -3 = PirateInvasion
     -4 = PumpkinMoon
     -5 = SnowMoon
     -6 = Eclipse
     -7 = Martian Moon
     -8 = Impending Doom
     -10 = Blood Moon
     -11 = Combat Book Used
     -12 = Bought Cat
     -13 = Bought Dog
     -14 = Bought Bunny
      4, 13, 50, 126, 125, 134, 127, 128, 131, 129, 130, 222, 245, 266, 370, 657
     */
    public var spawnType: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readInt16()
        self.spawnType = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(playerId)
        try writer.writeInt16(spawnType)
        payload.append(contentsOf: writer.data.bytes)
    }
}
