//
//  PacketTile.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

/// Modify a single tile (INCOMPLETE)
public struct PacketTile: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .Tile
    public var payload: [UInt8] = []
    public var action: UInt8 = 0
    public var tileX: Int16 = 0
    public var tileY: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.action = try reader.readUInt8()
        self.tileX = try reader.readInt16()
        self.tileY = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(action)
        try writer.writeInt16(tileX)
        try writer.writeInt16(tileY)
        payload.append(contentsOf: writer.data.bytes)
    }
}
