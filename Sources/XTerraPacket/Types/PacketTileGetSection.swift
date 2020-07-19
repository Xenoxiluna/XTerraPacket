//
//  PacketTileGetSection.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Client -> Server

import Foundation
import SwiftyBytes

/// Get tiles for spawn section
public struct PacketTileGetSection: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .TileGetSection
    public var payload: [UInt8] = []
    public var x: Int32 = 0
    public var y: Int32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.x = try reader.readInt32()
        self.y = try reader.readInt32()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt32(x)
        try writer.writeInt32(y)
        payload.append(contentsOf: writer.data.bytes)
    }
}
