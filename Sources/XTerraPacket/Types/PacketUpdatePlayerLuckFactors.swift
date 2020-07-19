//
//  PacketUpdatePlayerLuckFactors.swift
//
//
//  Created by Quentin Berry on 5/22/20.
//  Direction: Client <-> Server

import Foundation
import SwiftyBytes

/// Update player luck factors
public struct PacketUpdatePlayerLuckFactors: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .UpdatePlayerLuckFactors
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var ladyBugLuckTimeLeft: Int32 = 0
    public var torchLuck: Float32 = 0
    public var luckPotion: UInt8 = 0
    public var hasGardenGnomeNearby: Bool = false
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.ladyBugLuckTimeLeft = try reader.readInt32()
        self.torchLuck = try reader.readFloat32()
        self.luckPotion = try reader.readUInt8()
        self.hasGardenGnomeNearby = try reader.readBool()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeInt32(ladyBugLuckTimeLeft)
        try writer.writeFloat32(torchLuck)
        try writer.writeUInt8(luckPotion)
        try writer.writeBool(hasGardenGnomeNearby)
        payload.append(contentsOf: writer.data.bytes)
    }
}
