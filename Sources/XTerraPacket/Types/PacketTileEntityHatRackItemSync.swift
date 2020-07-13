//
//  PacketTileEntityHatRackItemSync.swift
//
//
//  Created by Quentin Berry on 5/22/20.
//

import Foundation
import SwiftyBytes

public struct PacketTileEntityHatRackItemSync: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .TileEntityHatRackItemSync
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var tileEntityId: Int32 = 0
    public var itemIndex: UInt8 = 0
    public var itemId: UInt16 = 0
    public var stack: UInt16 = 0
    public var prefix: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.tileEntityId = try reader.readInt32()
        self.itemIndex = try reader.readUInt8()
        self.itemId = try reader.readUInt16()
        self.stack = try reader.readUInt16()
        self.prefix = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeInt32(tileEntityId)
        try writer.writeUInt8(itemIndex)
        try writer.writeUInt16(itemId)
        try writer.writeUInt16(stack)
        try writer.writeUInt8(prefix)
        payload.append(contentsOf: writer.data.bytes)
    }
}
