//
//  PacketRemoveRevengeMarker.swift
//
//
//  Created by Quentin Berry on 5/22/20.
//  Direction: Server -> Client

import Foundation
import SwiftyBytes

/// Remove the revenge marker
public struct PacketRemoveRevengeMarker: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .RemoveRevengeMarker
    public var payload: [UInt8] = []
    public var id: Int32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.id = try reader.readInt32()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt32(id)
        payload.append(contentsOf: writer.data.bytes)
    }
}
