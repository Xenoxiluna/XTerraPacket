//
//  PacketEmoteBubble.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

// INCOMPLETE

import Foundation
import SwiftyBytes

public struct PacketEmoteBubble: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .EmoteBubble
    public var payload: [UInt8] = []
    public var emoteID: Int32 = 0
    public var anchorType: UInt8 = 0
    public var metaData: UInt16 = 0
    public var lifetime: UInt8 = 0
    public var emote: UInt8 = 0
    public var emoteMetaData: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.emoteID = try reader.readInt32()
        self.anchorType = try reader.readUInt8()
        if self.anchorType != 255 {
            self.metaData = try reader.readUInt16()
            self.lifetime = try reader.readUInt8()
            self.emote = try reader.readUInt8()
            if self.emote < 0 {
                self.emoteMetaData = try reader.readInt16()
            }
        }
    }
    mutating public func encodePayload() throws{
        print("Not Implemented")
    }
}
