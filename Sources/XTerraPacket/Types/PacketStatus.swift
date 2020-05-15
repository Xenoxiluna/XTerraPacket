//
//  PacketStatus.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketStatus: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .Status
    public var payload: [UInt8] = []
    public var statusMax: Int32 = 0
    public var textMode: UInt8 = 0
    public var text: String = ""
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.statusMax = try reader.readInt32()
        self.textMode = try reader.readUInt8()
        self.text = try reader.read7BitEncodedString()
        // Incomplete
    }
    mutating public func encodePayload() throws{
        print("Not Implemented")
    }
}
