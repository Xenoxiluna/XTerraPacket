//
//  PacketLandGolfBallInCup.swift
//
//
//  Created by Quentin Berry on 5/22/20.
//  Direction: Client <-> Server

import Foundation
import SwiftyBytes

/// Land Golf ball in cup
public struct PacketLandGolfBallInCup: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .LandGolfBallInCup
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var x: UInt16 = 0
    public var y: UInt16 = 0
    public var numberOfHits: UInt16 = 0
    public var projectileId: UInt16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.x = try reader.readUInt16()
        self.y = try reader.readUInt16()
        self.numberOfHits = try reader.readUInt16()
        self.projectileId = try reader.readUInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeUInt16(x)
        try writer.writeUInt16(y)
        try writer.writeUInt16(numberOfHits)
        try writer.writeUInt16(projectileId)
        payload.append(contentsOf: writer.data.bytes)
    }
}
