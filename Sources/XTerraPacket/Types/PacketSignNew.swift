//
//  PacketSignNew.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Client <-> Server

import Foundation
import SwiftyBytes

/// Update sign if changes from client. Display sign if sent from server
public struct PacketSignNew: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .SignNew
    public var payload: [UInt8] = []
    public var signId: Int16 = 0
    public var x: Int16 = 0
    public var y: Int16 = 0
    public var text: String = ""
    public var playerId: UInt8 = 0
    public var flags: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.signId = try reader.readInt16()
        self.x = try reader.readInt16()
        self.y = try reader.readInt16()
        self.text = try reader.readVariableLengthString(.utf8)
        self.playerId = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(signId)
        try writer.writeInt16(x)
        try writer.writeInt16(y)
        try writer.writeVariableLengthString(text, .utf8)
        try writer.writeUInt8(playerId)
        payload.append(contentsOf: writer.data.bytes)
    }
}
