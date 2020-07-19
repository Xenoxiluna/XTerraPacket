//
//  PacketCrystalInvasionSendWaitTime.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server -> Client

import Foundation
import SwiftyBytes

/// Time until Crystal Invasion or Next Wave
public struct PacketCrystalInvasionSendWaitTime: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .CrystalInvasionSendWaitTime
    public var payload: [UInt8] = []
    
    /// 30 seconds between waves, 5 seconds on first start
    public var timeUntilNextWave: Int32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.timeUntilNextWave = try reader.readInt32()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt32(timeUntilNextWave)
        payload.append(contentsOf: writer.data.bytes)
    }
}
