//
//  PacketChatText.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketChatText: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .ChatText
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var messageColorR: UInt8 = 0
    public var messageColorG: UInt8 = 0
    public var messageColorB: UInt8 = 0
    public var message: String = ""
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.messageColorR = try reader.readUInt8()
        self.messageColorG = try reader.readUInt8()
        self.messageColorB = try reader.readUInt8()
        self.message = try reader.readVariableLengthString(.utf8)
    }
    
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeUInt8(messageColorR)
        try writer.writeUInt8(messageColorG)
        try writer.writeUInt8(messageColorB)
        try writer.writeVariableLengthString(message, .utf8)
        payload.append(contentsOf: writer.data.bytes)
    }
}
