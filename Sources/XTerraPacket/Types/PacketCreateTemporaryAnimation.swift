//
//  PacketCreateTemporaryAnimation.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server -> Client

import Foundation
import SwiftyBytes

/// Create a temporary animation
public struct PacketCreateTemporaryAnimation: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .CreateTemporaryAnimation
    public var payload: [UInt8] = []
    public var animationType: Int16 = 0
    public var tileType: UInt16 = 0
    public var x: Int16 = 0
    public var y: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.animationType = try reader.readInt16()
        self.tileType = try reader.readUInt16()
        self.x = try reader.readInt16()
        self.y = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(animationType)
        try writer.writeUInt16(tileType)
        try writer.writeInt16(x)
        try writer.writeInt16(y)
        payload.append(contentsOf: writer.data.bytes)
    }
}
