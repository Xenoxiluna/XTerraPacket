//
//  PacketSyncPlayerChestIndex.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketSyncPlayerChestIndex: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .SyncPlayerChestIndex
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var chest: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.chest = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        print("Not Implemented")
    }
}
