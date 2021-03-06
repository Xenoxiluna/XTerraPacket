//
//  PacketPlayerAddBuff.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

public struct PacketPlayerAddBuff: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .PlayerAddBuff
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var buff: UInt16 = 0
    public var time: Int32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.buff = try reader.readUInt16()
        self.time = try reader.readInt32()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeUInt16(buff)
        try writer.writeInt32(time)
        payload.append(contentsOf: writer.data.bytes)
    }
}
