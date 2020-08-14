//
//  PacketItemOwner.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

/// Item Owner Update
public struct PacketItemOwner: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .ItemOwner
    public var payload: [UInt8] = []
    public var itemId: Int16 = 0
    public var playerId: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.itemId = try reader.readInt16()
        self.playerId = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(itemId)
        try writer.writeUInt8(playerId)
        payload.append(contentsOf: writer.data.bytes)
    }
}
