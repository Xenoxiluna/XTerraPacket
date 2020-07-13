//
//  PacketPlayerInfo.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

/// Payload Structure
/// Offset  |  Type  |  Description
///   1        UInt8    playerId
///   2        UInt8    skinVariant
///   3        UInt8    hair
///   4-x     String   playernane
///   5        UInt8    hairDye
///   6        UInt8    hideVisuals
///   7        UInt8    hideVisuals2
///   8        UInt8    hideMisc
///   9-11   UInt8    hairColor
///   12-15 UInt8    playerId
///   16-19 UInt8    playerId
///   20-23 UInt8    playerId
///   24-27 UInt8    playerId
///   28-31 UInt8    playerId
///   32-35 UInt8    playerId
///   36      UInt8    playerId
///
/// ----------------------------------
public struct PacketPlayerInfo: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .PlayerInfo
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var skinVariant: UInt8 = 0
    public var hair: UInt8 = 0
    public var name: String = ""
    public var hairDye: UInt8 = 0
    public var hideVisuals: UInt8 = 0
    public var hideVisuals2: UInt8 = 0
    public var hideMisc: UInt8 = 0
    public var hairColor: [UInt8] = []
    public var skinColor: [UInt8] = []
    public var eyeColor: [UInt8] = []
    public var shirtColor: [UInt8] = []
    public var underShirtColor: [UInt8] = []
    public var pantsColor: [UInt8] = []
    public var shoeColor: [UInt8] = []
    public var difficulty: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.skinVariant = try reader.readUInt8()
        self.hair = try reader.readUInt8()
        self.name = try reader.readVariableLengthString(.utf8)
        self.hairDye = try reader.readUInt8()
        self.hideVisuals = try reader.readUInt8()
        self.hideVisuals2 = try reader.readUInt8()
        self.hideMisc = try reader.readUInt8()
        self.hairColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.skinColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.eyeColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.shirtColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.underShirtColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.pantsColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.shoeColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.difficulty = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeUInt8(skinVariant)
        try writer.writeUInt8(hair)
        try writer.writeVariableLengthString(name, .utf8)
        try writer.writeUInt8(hairDye)
        try writer.writeUInt8(hideVisuals)
        try writer.writeUInt8(hideVisuals2)
        try writer.writeUInt8(hideMisc)
        try writer.write(hairColor)
        try writer.write(skinColor)
        try writer.write(eyeColor)
        try writer.write(shirtColor)
        try writer.write(underShirtColor)
        try writer.write(pantsColor)
        try writer.write(shoeColor)
        try writer.writeUInt8(difficulty)
        payload.append(contentsOf: writer.data.bytes)
    }
}