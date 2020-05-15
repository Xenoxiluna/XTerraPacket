//
//  PacketNpcKillCount.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketNpcKillCount: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .NpcKillCount
    public var payload: [UInt8] = []
    public var npcType: Int16 = 0
    public var killCount: Int32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.npcType = try reader.readInt16()
        self.killCount = try reader.readInt32()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(npcType)
        try writer.writeInt32(killCount)
        payload.append(contentsOf: writer.data)
    }
}
