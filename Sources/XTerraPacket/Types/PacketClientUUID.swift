//
//  PacketClientUUID.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Client -> Server

import Foundation
import SwiftyBytes

/// Client UUID
public struct PacketClientUUID: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ClientToServer
    public var packetType: TerrariaPacketType = .ClientUUID
    public var payload: [UInt8] = []
    public var UUID: String = ""
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.UUID = try reader.readVariableLengthString(.utf8)
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeVariableLengthString(UUID, .utf8)
        payload.append(contentsOf: writer.data.bytes)
    }
}
