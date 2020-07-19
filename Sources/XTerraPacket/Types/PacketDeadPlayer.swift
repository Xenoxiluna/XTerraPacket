//
//  PacketDeadPlayer.swift
//
//
//  Created by Quentin Berry on 5/22/20.
//  Direction: Server -> Client

import Foundation
import SwiftyBytes

/// A player has died
public struct PacketDeadPlayer: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .DeadPlayer
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        payload.append(contentsOf: writer.data.bytes)
    }
}
