//
//  PacketRequestNPCBuffRemoval.swift
//
//
//  Created by Quentin Berry on 5/22/20.
//  Direction: Client -> Server

import Foundation
import SwiftyBytes

/// Request for removal of an NPC's buffs
public struct PacketRequestNPCBuffRemoval: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ClientToServer
    public var packetType: TerrariaPacketType = .RequestNPCBuffRemoval
    public var payload: [UInt8] = []
    public var npcId: Int16 = 0
    public var buffIdToRemove: UInt16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.npcId = try reader.readInt16()
        self.buffIdToRemove = try reader.readUInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(npcId)
        try writer.writeUInt16(buffIdToRemove)
        payload.append(contentsOf: writer.data.bytes)
    }
}
