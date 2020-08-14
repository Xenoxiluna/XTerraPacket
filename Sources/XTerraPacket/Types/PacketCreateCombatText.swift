//
//  PacketCreateCombatText.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server -> Client

import Foundation
import SwiftyBytes

/// Create Combat Text
public struct PacketCreateCombatText: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .CreateCombatText
    public var payload: [UInt8] = []
    public var x: Float32 = 0
    public var y: Float32 = 0
    public var colorR: UInt8 = 0
    public var colorG: UInt8 = 0
    public var colorB: UInt8 = 0
    public var healAmount: Int32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.x = try reader.readFloat32()
        self.y = try reader.readFloat32()
        self.colorR = try reader.readUInt8()
        self.colorG = try reader.readUInt8()
        self.colorB = try reader.readUInt8()
        self.healAmount = try reader.readInt32()
    }
    
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeFloat32(x)
        try writer.writeFloat32(y)
        try writer.writeUInt8(colorR)
        try writer.writeUInt8(colorG)
        try writer.writeUInt8(colorB)
        try writer.writeInt32(healAmount)
        payload.append(contentsOf: writer.data.bytes)
    }
}
