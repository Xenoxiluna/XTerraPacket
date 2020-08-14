//
//  PacketStatus.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server -> Client

import Foundation
import SwiftyBytes

/// Status
public struct PacketStatus: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .Status
    public var payload: [UInt8] = []
    public var id: Int32 = 0
    public var text: String = ""
    public var flags: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.id = try reader.readInt32()
        self.text = try reader.readVariableLengthString(.utf8)
        self.flags = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt32(id)
        try writer.writeVariableLengthString(text, .utf8)
        try writer.writeUInt8(flags)
        payload.append(contentsOf: writer.data.bytes)
    }
}
