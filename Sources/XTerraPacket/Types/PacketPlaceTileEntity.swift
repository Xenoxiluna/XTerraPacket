//
//  PacketPlaceTileEntity.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Client -> Server

import Foundation
import SwiftyBytes

/// Place a tile entity
public struct PacketPlaceTileEntity: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ClientToServer
    public var packetType: TerrariaPacketType = .PlaceTileEntity
    public var payload: [UInt8] = []
    public var x: Int16 = 0
    public var y: Int16 = 0
    
    /// 2 = Logic Sensor; 1 = Item Frame; 0 = Training Dummy
    public var type: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.x = try reader.readInt16()
        self.y = try reader.readInt16()
        self.type = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(x)
        try writer.writeInt16(y)
        try writer.writeUInt8(type)
        payload.append(contentsOf: writer.data.bytes)
    }
}
