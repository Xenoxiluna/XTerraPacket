//
//  PacketPlaceObject.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client

import Foundation
import SwiftyBytes

/// Place an object
public struct PacketPlaceObject: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .PlaceObject
    public var payload: [UInt8] = []
    public var x: Int16 = 0
    public var y: Int16 = 0
    public var type: Int16 = 0
    public var style: Int16 = 0
    public var alternate: UInt8 = 0
    public var random: Int8 = 0
    public var direction: Bool = false
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.x = try reader.readInt16()
        self.y = try reader.readInt16()
        self.type = try reader.readInt16()
        self.style = try reader.readInt16()
        self.alternate = try reader.readUInt8()
        self.random = try reader.readInt8()
        self.direction = try reader.readBool()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(x)
        try writer.writeInt16(y)
        try writer.writeInt16(type)
        try writer.writeInt16(style)
        try writer.writeUInt8(alternate)
        try writer.writeInt8(random)
        try writer.writeBool(direction)
        payload.append(contentsOf: writer.data.bytes)
    }
}
