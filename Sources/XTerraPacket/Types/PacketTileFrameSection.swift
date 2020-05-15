//
//  PacketTileFrameSection.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketTileFrameSection: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .TileFrameSection
    public var payload: [UInt8] = []
    public var startX: Int16 = 0
    public var startY: Int16 = 0
    public var endX: Int16 = 0
    public var endY: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.startX = try reader.readInt16()
        self.startY = try reader.readInt16()
        self.endX = try reader.readInt16()
        self.endY = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        print("Not Implemented")
    }
}
