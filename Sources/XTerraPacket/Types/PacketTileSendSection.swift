//
//  PacketTileSendSection.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server -> Client

import Foundation
import SwiftyBytes

/// Tile send section (INCOMPLETE)
public struct PacketTileSendSection: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .TileSendSection
    public var payload: [UInt8] = []
    public var tiles: [UInt8] = []
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.tiles = try reader.read(payload.count) // Find a way to read tile data
    }
    mutating public func encodePayload() throws{
        print("Not Implemented")
        /*self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt32(healAmount)
        try writer.writeVariableLengthString(text, .utf8)
        payload.append(contentsOf: writer.data.bytes)*/
    }
}
