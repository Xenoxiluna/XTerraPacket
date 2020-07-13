# `XTerraPacket`
[![Swift 5.X](https://img.shields.io/badge/Swift-5.X-blue.svg)](https://developer.apple.com/swift/)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](LICENSE)
[![Docs](http://img.shields.io/badge/read_the-docs-2196f3.svg)](https://xenoxiluna.github.io/XTerraPacket/index.html)

A Packet Library for encoding and decoding Terraria's network protocol packets.

 ## Usage
 Brief example using SwiftNIO for now... You can also look at [TerraProxy-CLI](https://github.com/Xenoxiluna/TerraProxy-CLI) for inspiration/uses.
 
 ### Decode
 You can decode an incoming packet's raw bytes like this:
```swift
let packetData = bb.getBytes(at: 0, length: bb.readableBytes)!
guard var packet = try? TerrariaPacketFactory.decodePacket(packet: packetData) else {
    print("Parse failed!")
    print("Failed bytes: \(packetData))")
    channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    return
}
```

Once you have a valid packet, you can view its type using the swifts dynamic type(of:) function or using the provided getType() protocol extension.
```swift
print("Swift Packet type: \(type(of: packet))")
print("Packet Type: \(packet.getType())")
```

Form there, its possible to run the decode again to translate the payload. You could also just use the packets decodePayload() function.
```swift
do{
    try packet.decode()
    print("Decoded Packet Bytes: \(packet.bytes))")
}catch{
    print("Decode failed...")
    print("Failed Packet Bytes: \(packet.bytes))")
    return
}

switch packet.getType(){
case TerrariaPacketType.ConnectApproval:
    let appPacket = packet as! PacketConnectApproval
    connection.setPlayerId(playerId: Int(appPacket.playerId))
default:
    print("")
}
```
 
 ### Encode
 TODO
 For now, See API Documentation for encode functionality.
 
 ## Dependencies

- [SwiftyBytes 0.2.3](https://github.com/Xenoxiluna/SwiftyBytes)

 ## License

 `XTerraPacket` is licensed under the [MIT License](LICENSE)
