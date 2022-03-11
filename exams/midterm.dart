import 'package:cisco_ios_dsl/cisco_ios_dsl.dart';

void run() {

  const motd = 'Unauthorized access is strictly prohibited.';

  const configPassword = 'class';
  const remotePassword = 'cisco';

  Device('router').enable((x) => x
    ..configure((x) => x
      ..setHostname('R1')
      ..ip.dnsLookup.disable()
      ..setMessageOfTheDay(motd)
      ..setConfigPassword(configPassword)
      ..lines('console 0', (x) => x
        ..password.enable(remotePassword)
        ..login.enable()
      )
      ..lines('vty 0 15', (x) => x
        ..password.enable(remotePassword)
        ..login.enable()
      )
      ..interface('g0/0/0', (x) => x
      )
      ..subinterface('g0/0/0.10', (x) => x
      )
      ..subinterface('g0/0/0.20', (x) => x
      )
      ..subinterface('g0/0/0.30', (x) => x
      )
      ..subinterface('g0/0/0.99', (x) => x
      )
      ..interface('g0/0/1', (x) => x
      )
    )
  );
  
  print('----------------------------------------');

  Device('router').enable((x) => x
    ..configure((x) => x
      ..setHostname('R2')
      ..ip.dnsLookup.disable()
      ..setMessageOfTheDay(motd)
      ..setConfigPassword(configPassword)
      ..lines('console 0', (x) => x
        ..password.enable(remotePassword)
        ..login.enable()
      )
      ..lines('vty 0 15', (x) => x
        ..password.enable(remotePassword)
        ..login.enable()
      )
      ..interface('g0/0/0', (x) => x
      )
      ..interface('g0/0/1', (x) => x
      )
    )
  );
  
  print('----------------------------------------');

  Device('switch').enable((x) => x
    ..configure((x) => x
      ..setHostname('S1')
      ..ip.dnsLookup.disable()
      ..setMessageOfTheDay(motd)
      ..setConfigPassword(configPassword)
      ..lines('console 0', (x) => x
        ..password.enable(remotePassword)
        ..login.enable()
      )
      ..lines('vty 0 15', (x) => x
        ..password.enable(remotePassword)
        ..login.enable()
      )
      ..vlan(10, (x) => x
        ..setName('Student')
      )
      ..vlan(20, (x) => x
        ..setName('Faculty')
      )
      ..vlan(30, (x) => x
        ..setName('HR')
      )
      ..vlan(99, (x) => x
        ..setName('Management')
      )
      ..interfaces('f0/5-23, g0/0-1', (x) => x
        ..operation.disable()
      )
      ..interfaces('f0/1-2', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans([10, 20, 30, 99])
        ..etherChannel.enableLACP(1)
        ..operation.enable()
      )
      ..interfaces('f0/3-4', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans([10, 20, 30, 99])
        ..etherChannel.enablePAgP(2)
        ..operation.enable()
      )
      ..interface('f0/24', (x) => x
        ..switchport.access.enable()
        ..switchport.access.setVlans([10, 20, 30, 99])
        ..operation.enable()
      )
      ..interface('vlan 99', (x) => x
        ..ip.setGateway(IPv4.fromCidr('', 2)) // TODO
      )
    )
  );
  
  print('----------------------------------------');

  Device('switch').enable((x) => x
    ..configure((x) => x
      ..setHostname('S2')
      ..ip.dnsLookup.disable()
      ..setMessageOfTheDay(motd)
      ..setConfigPassword(configPassword)
      ..lines('console 0', (x) => x
        ..password.enable(remotePassword)
        ..login.enable()
      )
      ..lines('vty 0 15', (x) => x
        ..password.enable(remotePassword)
        ..login.enable()
      )
      ..vlan(10, (x) => x
        ..setName('Student')
      )
      ..vlan(20, (x) => x
        ..setName('Faculty')
      )
      ..vlan(30, (x) => x
        ..setName('HR')
      )
      ..vlan(99, (x) => x
        ..setName('Management')
      )
      ..interface('vlan 99', (x) => x
      )
    )
  );
  
  print('----------------------------------------');

  Device('switch').enable((x) => x
    ..configure((x) => x
      ..setHostname('S3')
      ..ip.dnsLookup.disable()
      ..setMessageOfTheDay(motd)
      ..setConfigPassword(configPassword)
      ..lines('console 0', (x) => x
        ..password.enable(remotePassword)
        ..login.enable()
      )
      ..lines('vty 0 15', (x) => x
        ..password.enable(remotePassword)
        ..login.enable()
      )
      ..vlan(10, (x) => x
        ..setName('Student')
      )
      ..vlan(20, (x) => x
        ..setName('Faculty')
      )
      ..vlan(30, (x) => x
        ..setName('HR')
      )
      ..vlan(99, (x) => x
        ..setName('Management')
      )
      ..interface('vlan 99', (x) => x
      )
    )
  );
  
  print('----------------------------------------');

  Device('switch').enable((x) => x
    ..configure((x) => x
      ..setHostname('S4')
      ..ip.dnsLookup.disable()
      ..setMessageOfTheDay(motd)
    )
  );
}
