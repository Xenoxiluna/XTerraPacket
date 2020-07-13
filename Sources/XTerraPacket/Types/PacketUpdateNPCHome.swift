//
//  PacketUpdateNPCHome.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketUpdateNPCHome: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .UpdateNPCHome
    public var payload: [UInt8] = []
    public var npcId: Int16 = 0
    public var homeTileX: Int16 = 0
    public var homeTileY: Int16 = 0
    public var homeless: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.npcId = try reader.readInt16()
        self.homeTileX = try reader.readInt16()
        self.homeTileY = try reader.readInt16()
        self.homeless = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(npcId)
        try writer.writeInt16(homeTileX)
        try writer.writeInt16(homeTileY)
        try writer.writeUInt8(homeless)
        payload.append(contentsOf: writer.data.bytes)
    }
}
