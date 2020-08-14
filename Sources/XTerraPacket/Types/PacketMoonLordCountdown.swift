//
//  PacketMoonLordCountdown.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server -> Client

import Foundation
import SwiftyBytes

/// Countdown before MoonLord Start
public struct PacketMoonLordCountdown: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .MoonLordCountdown
    public var payload: [UInt8] = []
    public var moonLordCountdown: Int32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.moonLordCountdown = try reader.readInt32()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt32(moonLordCountdown)
        payload.append(contentsOf: writer.data.bytes)
    }
}
