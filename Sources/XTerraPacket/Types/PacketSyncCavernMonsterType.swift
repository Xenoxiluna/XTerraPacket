//
//  PacketSyncCavernMonsterType.swift
//
//
//  Created by Quentin Berry on 5/22/20.
//  Direction: Client <-> Server

import Foundation
import SwiftyBytes

/// Sync type of cavern monster
public struct PacketSyncCavernMonsterType: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .SyncCavernMonsterType
    public var payload: [UInt8] = []
    public var cavernMonsterType: [[UInt16]] = [[UInt16]](repeating: [UInt16](repeating: 0, count: 3), count: 2)
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        for k in 0...1 {
            for l in 0...2 {
                self.cavernMonsterType[k][l] = try reader.readUInt16()
            }
        }
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        for k in 0...1 {
            for l in 0...2 {
                try writer.writeUInt16(self.cavernMonsterType[k][l])
            }
        }
        payload.append(contentsOf: writer.data.bytes)
    }
}
