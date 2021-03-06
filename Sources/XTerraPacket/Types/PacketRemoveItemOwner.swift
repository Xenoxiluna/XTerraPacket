//
//  PacketRemoveItemOwner.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server -> Client.

import Foundation
import SwiftyBytes

/// Remove item Owner
public struct PacketRemoveItemOwner: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .RemoveItemOwner
    public var payload: [UInt8] = []
    public var itemIndex: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.itemIndex = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(itemIndex)
        payload.append(contentsOf: writer.data.bytes)
    }
}
