//
//  PacketTimeSet.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketTimeSet: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .TimeSet
    public var payload: [UInt8] = []
    public var dayTime: Bool = false
    public var timeValue: Int32 = 0
    public var sunModY: Int16 = 0
    public var moonModY: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.dayTime = try reader.readBool()
        self.timeValue = try reader.readInt32()
        self.sunModY = try reader.readInt16()
        self.moonModY = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeBool(dayTime)
        try writer.writeInt32(timeValue)
        try writer.writeInt16(sunModY)
        try writer.writeInt16(moonModY)
        payload.append(contentsOf: writer.data.bytes)
    }
}
