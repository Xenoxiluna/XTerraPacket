//
//  PacketCreateCombatTextExtended.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Client <-> Server

import Foundation
import SwiftyBytes

/// Combat Text String
public struct PacketCreateCombatTextExtended: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .CreateCombatTextExtended
    public var payload: [UInt8] = []
    public var positionX: Float32 = 0
    public var positionY: Float32 = 0
    public var colorR: UInt8 = 0
    public var colorG: UInt8 = 0
    public var colorB: UInt8 = 0
    public var combatText: String = ""
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.positionX = try reader.readFloat32()
        self.positionY = try reader.readFloat32()
        self.colorR = try reader.readUInt8()
        self.colorG = try reader.readUInt8()
        self.colorB = try reader.readUInt8()
        self.combatText = try reader.readVariableLengthString(.utf8)
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeFloat32(positionX)
        try writer.writeFloat32(positionY)
        try writer.writeUInt8(colorR)
        try writer.writeUInt8(colorG)
        try writer.writeUInt8(colorB)
        try writer.writeVariableLengthString(combatText, .utf8)
        payload.append(contentsOf: writer.data.bytes)
    }
}
