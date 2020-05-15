//
//  PacketTravellingMerchantInventory.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketTravellingMerchantInventory: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .TravellingMerchantInventory
    public var payload: [UInt8] = []
    public static let MAX_ITEMS = 40
    public var items: [Int16] = []
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        for _ in 0..<PacketTravellingMerchantInventory.MAX_ITEMS{
            items += [try reader.readInt16()]
        }
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        
        for i in items{
            try writer.writeInt16(i)
        }
        
        payload.append(contentsOf: writer.data)
    }
}
