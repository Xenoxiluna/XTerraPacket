//
//  PacketNumberOfAnglerQuestsCompleted.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketNumberOfAnglerQuestsCompleted: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .NumberOfAnglerQuestsCompleted
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var anglerQuestsCompleted: Int32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.anglerQuestsCompleted = try reader.readInt32()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeInt32(anglerQuestsCompleted)
        payload.append(contentsOf: writer.data.bytes)
    }
}
