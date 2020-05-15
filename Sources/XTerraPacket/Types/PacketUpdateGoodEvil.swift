//
//  PacketUpdateGoodEvil.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketUpdateGoodEvil: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .UpdateGoodEvil
    public var payload: [UInt8] = []
    public var good: UInt8 = 0
    public var evil: UInt8 = 0
    public var crimson: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.good = try reader.readUInt8()
        self.evil = try reader.readUInt8()
        self.crimson = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(good)
        try writer.writeUInt8(evil)
        try writer.writeUInt8(crimson)
        payload.append(contentsOf: writer.data)
    }
}
