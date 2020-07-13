//
//  PacketDisconnect.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketDisconnect: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .Disconnect
    public var payload: [UInt8] = []
    public var text: String = ""
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.text = try reader.readVariableLengthString(.utf8)
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeVariableLengthString(text, .utf8)
        payload.append(contentsOf: writer.data.bytes)
    }
}
