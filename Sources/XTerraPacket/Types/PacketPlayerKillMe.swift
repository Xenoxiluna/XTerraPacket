//
//  PacketPlayerKillMe.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketPlayerKillMe: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .PlayerKillMe
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var hitDirection: UInt8 = 0
    public var damage: Int16 = 0
    public var pvp: Bool = false
    public var deathText: String = ""
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.hitDirection = try reader.readUInt8()
        self.damage = try reader.readInt16()
        self.pvp = try reader.readBool()
        self.deathText = try reader.read7BitEncodedString()
    }
    mutating public func encodePayload() throws{
        print("Not Implemented")
    }
}
