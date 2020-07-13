//
//  PacketPlaceChest.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketPlaceChest: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .PlaceChest
    public var payload: [UInt8] = []
    public var chestId: UInt8 = 0
    public var tileX: Int16 = 0
    public var tileY: Int16 = 0
    public var style: Int16 = 0
    public var chestIdDestroy: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.chestId = try reader.readUInt8()
        self.tileX = try reader.readInt16()
        self.tileY = try reader.readInt16()
        self.style = try reader.readInt16()
        self.chestIdDestroy = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(chestId)
        try writer.writeInt16(tileX)
        try writer.writeInt16(tileY)
        try writer.writeInt16(style)
        try writer.writeInt16(chestIdDestroy)
        payload.append(contentsOf: writer.data.bytes)
    }
}
