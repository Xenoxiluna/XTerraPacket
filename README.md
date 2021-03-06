# `XTerraPacket`
[![Swift 5.X](https://img.shields.io/badge/Swift-5.X-blue.svg)](https://developer.apple.com/swift/)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](LICENSE)
[![Docs](http://img.shields.io/badge/read_the-docs-2196f3.svg)](https://xenoxiluna.github.io/XTerraPacket/index.html)

A Packet Library for encoding and decoding Terraria's network protocol packets.

#### NOTE: Currently this supports only Terraria 1.4.X

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
try packet.decode(.ClientToServer)
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
 See [API Documentation](https://xenoxiluna.github.io/XTerraPacket/index.html) for encode functionality.
 
 Chat Message Example:
 ```swift
 var load = PacketLoadNetModule()
 load.netModuleType = .Chat
 load.context = .ClientToServer
 load.netModule = NetModuleChat(command: .Say, message: "this is a test")
 do{
     try load.encode()
 }catch {}
 ```
 
 ## Dependencies

- [SwiftyBytes 0.4.0](https://github.com/Xenoxiluna/SwiftyBytes)

 ## License

 `XTerraPacket` is licensed under the [MIT License](LICENSE)
