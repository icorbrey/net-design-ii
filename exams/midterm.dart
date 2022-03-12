import 'package:cisco_ios_dsl/cisco_ios_dsl.dart';

var subnets = {
  'A': IPv4.fromCidr('172.16.128.0', 25),   /// VLAN 10
  'B': IPv4.fromCidr('172.16.128.128', 25), /// VLAN 20
  'C': IPv4.fromCidr('172.16.129.0', 26),   /// VLAN 30
  'D': IPv4.fromCidr('172.16.129.64', 29),  /// VLAN 99
  'E': IPv4.fromCidr('172.16.129.80', 30),
  'F': IPv4.fromCidr('172.16.129.72', 29),
};

var vlans = {
  10: 'Student',
  20: 'Faculty',
  30: 'HR',
  99: 'Management',
};

var ipAddresses = {
  'R1': {
    'g0/0/0.10': IPv4.fromCidr('172.16.128.127', 25),
    'g0/0/0.20': IPv4.fromCidr('172.16.128.255', 25),
    'g0/0/0.30': IPv4.fromCidr('172.16.129.63', 26),
    'g0/0/0.99': IPv4.fromCidr('172.16.129.83', 29),
    'g0/0/1': IPv4.fromCidr('172.16.128.81', 30),
  },
  'R2': {
    'g0/0/0': IPv4.fromCidr('172.16.128.73', 29),
    'g0/0/1': IPv4.fromCidr('172.16.128.82', 30),
  },
  'S1': {
    'vlan 99': IPv4.fromCidr('172.16.129.66', 29),
  },
  'S2': {
    'vlan 99': IPv4.fromCidr('172.16.129.67', 29),
  },
  'S3': {
    'vlan 99': IPv4.fromCidr('172.16.129.68', 29),
  },
};

var ipv6Addresses = {
  'R1': {
    'g0/0/1': IPv6.fromCidr('SLAAC', 69),
  },
  'R2': {
    'g0/0/0': IPv6.fromCidr('2001:abc:456:11:1', 64),
    'g0/0/1': IPv6.fromCidr('2001:abc:456:10:1', 64),
  },
};

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
      ..services.passwordEncryption.enable()
      ..lines('console 0', (x) => x
        ..password.enable(remotePassword)
        ..login.enable()
      )
      ..lines('vty 0 15', (x) => x
        ..password.enable(remotePassword)
        ..login.enable()
      )
      ..interface('g0/0/0', (x) => x
        // TODO IPv6 SLACC address
      )
      ..subinterface('g0/0/0.10', (x) => x
        ..ip.setGateway(ipAddresses['R1']['g0/0/0.10'])
        ..encapsulateVlan(10)
        ..operation.enable()
      )
      ..subinterface('g0/0/0.20', (x) => x
        ..ip.setGateway(ipAddresses['R1']['g0/0/0.20'])
        ..encapsulateVlan(20)
        ..operation.enable()
      )
      ..subinterface('g0/0/0.30', (x) => x
        ..ip.setGateway(ipAddresses['R1']['g0/0/0.30'])
        ..encapsulateVlan(30)
        ..operation.enable()
      )
      ..subinterface('g0/0/0.99', (x) => x
        ..ip.setGateway(ipAddresses['R1']['g0/0/0.99'])
        ..encapsulateVlan(99)
        ..operation.enable()
      )
      ..interface('g0/0/1', (x) => x
        ..ip.setGateway(ipAddresses['R1']['g0/0/1'])
        ..ipv6.addGateway(ipv6Addresses['R1']['g0/0/1'])
        ..operation.enable()
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
      ..services.passwordEncryption.enable()
      ..lines('console 0', (x) => x
        ..password.enable(remotePassword)
        ..login.enable()
      )
      ..lines('vty 0 15', (x) => x
        ..password.enable(remotePassword)
        ..login.enable()
      )
      ..interface('g0/0/0', (x) => x
        ..ip.setGateway(ipAddresses['R2']['g0/0/0'])
        ..ipv6.addGateway(ipv6Addresses['R2']['g0/0/0'])
        ..operation.enable()
      )
      ..interface('g0/0/1', (x) => x
        ..ip.setGateway(ipAddresses['R2']['g0/0/1'])
        ..ipv6.addGateway(ipv6Addresses['R2']['g0/0/1'])
        ..operation.enable()
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
      ..services.passwordEncryption.enable()
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
        ..ip.setGateway(ipAddresses['S1']['vlan 99'])
      )
      ..spanningTree.enableRapidPVST()
      ..spanningTree.setPriorityValueByOffset(10, -1)
      ..spanningTree.portfast.enable('0/24')
      ..spanningTree.portfast.bpduGuard.enable('0/24')
    )
    ..saveConfig()
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
      ..interfaces('f0/1-2, f0/7-22, g0/0-1', (x) => x
        ..operation.disable()
      )
      ..interfaces('f0/3-4', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans([10, 20, 30, 99])
        ..etherChannel.enablePAgP(2)
        ..operation.enable()
      )
      ..interfaces('f0/5-6', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans([10, 20, 30, 99])
        ..etherChannel.enablePAgP(3)
        ..operation.enable()
      )
      ..interfaces('f0/23-24', (x) => x
        ..switchport.access.enable()
        ..switchport.access.setVlans([10, 20, 30, 99])
        ..operation.enable()
      )
      ..interface('vlan 99', (x) => x
        ..ip.setGateway(ipAddresses['S2']['vlan 99'])
      )
      ..spanningTree.enableRapidPVST()
      ..spanningTree.setPriorityValueByOffset(20, -1)
      ..spanningTree.portfast.enable('0/23')
      ..spanningTree.portfast.enable('0/24')
      ..spanningTree.portfast.bpduGuard.enable('0/23')
      ..spanningTree.portfast.bpduGuard.enable('0/24')
    )
    ..saveConfig()
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
      ..interfaces('f0/3-4, f0/7-23, g0/0-', (x) => x
        ..operation.disable()
      )
      ..interfaces('f0/1-2', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans([10, 20, 30, 99])
        ..etherChannel.enableLACP(1)
        ..operation.enable()
      )
      ..interfaces('f0/5-6', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans([10, 20, 30, 99])
        ..etherChannel.enablePAgP(3)
        ..operation.enable()
      )
      ..interface('f0/24', (x) => x
        ..switchport.access.enable()
        ..switchport.access.setVlans([10, 20, 30, 99])
        ..operation.enable()
      )
      ..interface('g0/1', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans([10, 20, 30, 99])
        ..operation.enable()
      )
      ..interface('vlan 99', (x) => x
        ..ip.setGateway(ipAddresses['S3']['vlan 99'])
      )
      ..spanningTree.enableRapidPVST()
      ..spanningTree.setPriorityValueByOffset(30, -1)
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
