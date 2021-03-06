//
//  PacketEmoteBubble.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server -> Client

import Foundation
import SwiftyBytes

/// Sync Emote bubble
public struct PacketEmoteBubble: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .EmoteBubble
    public var payload: [UInt8] = []
    public var emoteID: Int32 = 0
    public var anchorType: UInt8 = 0
    public var metaData: UInt16 = 0
    public var lifetime: UInt8 = 0
    public var emote: Int8 = 0
    public var emoteMetaData: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.emoteID = try reader.readInt32()
        self.anchorType = try reader.readUInt8()
        if self.anchorType != 255 {
            self.metaData = try reader.readUInt16()
            self.lifetime = try reader.readUInt8()
            self.emote = try reader.readInt8()
            if self.emote < 0 {
                self.emoteMetaData = try reader.readInt16()
            }
        }
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt32(emoteID)
        try writer.writeUInt8(anchorType)
        if self.anchorType != 255 {
            try writer.writeUInt16(metaData)
            try writer.writeUInt8(lifetime)
            try writer.writeInt8(emote)
            if self.emote < 0{
                try writer.writeInt16(emoteMetaData)
            }
        }
        payload.append(contentsOf: writer.data.bytes)
    }
}
