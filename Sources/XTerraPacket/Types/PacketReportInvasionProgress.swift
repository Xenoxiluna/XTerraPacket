//
//  PacketReportInvasionProgress.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketReportInvasionProgress: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .ReportInvasionProgress
    public var payload: [UInt8] = []
    public var progress: Int32 = 0
    public var maxProgress: Int32 = 0
    public var icon: Int8 = 0
    public var wave: Int8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.progress = try reader.readInt32()
        self.maxProgress = try reader.readInt32()
        self.icon = try reader.readInt8()
        self.wave = try reader.readInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt32(progress)
        try writer.writeInt32(maxProgress)
        try writer.writeInt8(icon)
        try writer.writeInt8(wave)
        payload.append(contentsOf: writer.data)
    }
}
