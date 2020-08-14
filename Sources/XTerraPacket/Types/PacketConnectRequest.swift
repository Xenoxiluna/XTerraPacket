//
//  PacketConnectRequest.swift
//  
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Client -> Server

import Foundation
import SwiftyBytes

/// Connection Request Packet
public struct PacketConnectRequest: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ClientToServer
    public var packetType: TerrariaPacketType = .ConnectRequest
    public var payload: [UInt8] = []
    public var version: String = ""
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        let strlen = Int(try reader.readUInt8())
        self.version = try reader.readUTF8String(strlen)
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(UInt8(version.count))
        try writer.writeString(version, .utf8)
        payload.append(contentsOf: writer.data.bytes)
    }
}
