//
//  PacketPlayerBuff.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

/// Update player buffs
public struct PacketPlayerBuff: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .PlayerBuff
    public var payload: [UInt8] = []
    private let MAX_BUFFS = 22
    
    public var playerId: UInt8 = 0
    public var buffs: [UInt8] = []
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        
        for _ in 0..<self.MAX_BUFFS{
            buffs += [try reader.readUInt8()]
        }
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.write(buffs)
        payload.append(contentsOf: writer.data.bytes)
    }
}
