//
//  PacketKillPortal.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Client -> Server

import Foundation
import SwiftyBytes

/// Kill portal
public struct PacketKillPortal: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .KillPortal
    public var payload: [UInt8] = []
    public var projectileIndex: UInt16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.projectileIndex = try reader.readUInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt16(projectileIndex)
        payload.append(contentsOf: writer.data.bytes)
    }
}
