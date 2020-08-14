//
//  PacketTeleportationPotion.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client

import Foundation
import SwiftyBytes

/// Teleportation potion
public struct PacketTeleportationPotion: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .TeleportationPotion
    public var payload: [UInt8] = []
    
    /// 0 = Teleportation Potion; 1 = Magic Conch; 2 = Demon Conch
    public var potionType: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.potionType = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(potionType)
        payload.append(contentsOf: writer.data.bytes)
    }
}
