//
//  PacketTileFrameSection.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server -> Client

import Foundation
import SwiftyBytes

/// Section tile frame
public struct PacketTileFrameSection: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .TileFrameSection
    public var payload: [UInt8] = []
    public var startX: Int16 = 0
    public var startY: Int16 = 0
    public var endX: Int16 = 0
    public var endY: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.startX = try reader.readInt16()
        self.startY = try reader.readInt16()
        self.endX = try reader.readInt16()
        self.endY = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(startX)
        try writer.writeInt16(startY)
        try writer.writeInt16(endX)
        try writer.writeInt16(endY)
        payload.append(contentsOf: writer.data.bytes)
    }
}
