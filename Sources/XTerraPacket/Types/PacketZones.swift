//
//  PacketZones.swift
//
//
//  Created by Quentin Berry on 5/10/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

/// Player zone
public struct PacketZones: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ClientToServer
    public var packetType: TerrariaPacketType = .Zones
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var zone1: UInt8 = 0
    public var zone2: UInt8 = 0
    public var zone3: UInt8 = 0
    public var zone4: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.zone1 = try reader.readUInt8()
        self.zone2 = try reader.readUInt8()
        self.zone3 = try reader.readUInt8()
        self.zone4 = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeUInt8(zone1)
        try writer.writeUInt8(zone2)
        try writer.writeUInt8(zone3)
        try writer.writeUInt8(zone4)
        payload.append(contentsOf: writer.data.bytes)
    }
}
