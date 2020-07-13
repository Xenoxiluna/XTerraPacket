//
//  PacketAnglerQuest.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

/// Information about an angler quest.
public struct PacketAnglerQuest: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .AnglerQuest
    public var payload: [UInt8] = []
    public var quest: UInt8 = 0
    public var completed: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        quest = try reader.readUInt8()
        completed = try reader.readUInt8()
    }
    
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(quest)
        try writer.writeUInt8(completed)
        payload.append(contentsOf: writer.data.bytes)
    }
}