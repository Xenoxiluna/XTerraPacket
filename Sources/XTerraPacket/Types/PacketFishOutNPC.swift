//
//  PacketFishOutNPC.swift
//
//
//  Created by Quentin Berry on 5/22/20.
//  Direction: Client -> Server

import Foundation
import SwiftyBytes

/// Fish out a NPC
public struct PacketFishOutNPC: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .FishOutNPC
    public var payload: [UInt8] = []
    public var x: UInt16 = 0
    public var y: UInt16 = 0
    public var npcId: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.x = try reader.readUInt16()
        self.y = try reader.readUInt16()
        self.npcId = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt16(x)
        try writer.writeUInt16(y)
        try writer.writeInt16(npcId)
        payload.append(contentsOf: writer.data.bytes)
    }
}
