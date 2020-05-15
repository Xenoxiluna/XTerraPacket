//
//  PacketTileGetSection.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

/// Payload Structure
/// Offset  |  Type  |  Description
///   1-4        UInt32    x
///   5-8        UInt32    y
///
/// ----------------------------------
public struct PacketTileGetSection: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .TileGetSection
    public var payload: [UInt8] = []
    public var x: UInt32 = 0
    public var y: UInt32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.x = try reader.readUInt32()
        self.y = try reader.readUInt32()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt32(x)
        try writer.writeUInt32(y)
        payload.append(contentsOf: writer.data)
    }
}
