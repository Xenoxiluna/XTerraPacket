//
//  PacketPlayerActive.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server -> Client

import Foundation
import SwiftyBytes

/// Is player active?
public struct PacketPlayerActive: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .PlayerActive
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var active: Bool = false
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.active = try reader.readBool()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeBool(active)
        payload.append(contentsOf: writer.data.bytes)
    }
}
