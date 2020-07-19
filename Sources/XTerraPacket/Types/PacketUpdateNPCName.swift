//
//  PacketUpdateNPCName.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

/// Update NPC name
public struct PacketUpdateNPCName: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .UpdateNPCName
    public var payload: [UInt8] = []
    public var npcId: Int16 = 0
    
    // Only on client receiving packet
    public var name: String = ""
    
    // Only on client receiving packet
    public var townNpcVariationIndex: Int32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.npcId = try reader.readInt16()
        if (reader.data.bytes.count > reader.readIndex) {
            self.name = try reader.readVariableLengthString(.utf8)
            self.townNpcVariationIndex = try reader.readInt32()
        }
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(npcId)
        if name != ""{
            try writer.writeVariableLengthString(name, .utf8)
            try writer.writeInt32(townNpcVariationIndex)
        }
        payload.append(contentsOf: writer.data.bytes)
    }
}
