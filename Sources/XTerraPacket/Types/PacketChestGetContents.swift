//
//  PacketChestGetContents.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketChestGetContents: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .ChestGetContents
    public var payload: [UInt8] = []
    public var tileX: Int16 = 0
    public var tileY: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.tileX = try reader.readInt16()
        self.tileY = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(tileX)
        try writer.writeInt16(tileY)
        payload.append(contentsOf: writer.data)
    }
}
