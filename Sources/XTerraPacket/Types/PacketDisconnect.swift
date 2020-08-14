//
//  PacketDisconnect.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server -> Client

import Foundation
import SwiftyBytes

/// Disconnect/Kick a connected client
public struct PacketDisconnect: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .Disconnect
    public var payload: [UInt8] = []
    public var reason: String = ""
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.reason = try reader.readVariableLengthString(.utf8)
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeVariableLengthString(reason, .utf8)
        payload.append(contentsOf: writer.data.bytes)
    }
}
