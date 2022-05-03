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
    'g0/0/0.10': IPv4.fromCidr('172.16.128.126', 25),
    'g0/0/0.20': IPv4.fromCidr('172.16.128.254', 25),
    'g0/0/0.30': IPv4.fromCidr('172.16.129.62', 26),
    'g0/0/0.99': IPv4.fromCidr('172.16.129.71', 29),
    'g0/0/1': IPv4.fromCidr('172.16.129.81', 29),
    'dhcp-A-exclusion-start': IPv4.noMask('172.16.128.1'),
    'dhcp-A-exclusion-end': IPv4.noMask('172.16.128.10'),
    'dhcp-B-exclusion-start': IPv4.noMask('172.16.128.129'),
    'dhcp-B-exclusion-end': IPv4.noMask('172.16.128.138'),
    'dhcp-C-exclusion-start': IPv4.noMask('172.16.129.1'),
    'dhcp-C-exclusion-end': IPv4.noMask('172.16.129.10'),
    'dhcp-F-exclusion': IPv4.noMask('172.16.129.73'),
    'dns-server': IPv4.noMask('10.10.10.10'),
    'default-route': IPv4.fromMask('0.0.0.0', '0.0.0.0'),
  },
  'R2': {
    'g0/0/0': IPv4.fromCidr('172.16.128.73', 29),
    'g0/0/1': IPv4.fromCidr('172.16.128.82', 30),
    'default-route': IPv4.fromMask('0.0.0.0', '0.0.0.0'),
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
    'default-route': IPv6.fromCidr('::', 0),
  },
  'R2': {
    'g0/0/0': IPv6.fromCidr('2001:abc:456:11::1', 64),
    'g0/0/1': IPv6.fromCidr('2001:abc:456:10::1', 64),
    'dhcp-dns-server': IPv6.noMask('2001:0:0:a::1'),
    'default-route': IPv6.fromCidr('::', 0),
  },
};

void run() {

  const motd = 'Unauthorized access is strictly prohibited.';

  const configPassword = 'class';
  const remotePassword = 'cisco';

  print('>>> R1 <<<\n');

  Device('router').enable((x) => x
    ..configure((x) => x
      ..setHostname('R1')
      ..ip.dnsLookup.disable()
      ..setMessageOfTheDay(motd)
      ..setConfigPassword(configPassword)
      ..services.passwordEncryption.enable()
      ..ip.setDomainName('ccna.com')
      ..lines('console 0', (x) => x
        ..password.enable(remotePassword)
        ..login.enable()
      )
      ..lines('vty 0 15', (x) => x
        ..password.enable(remotePassword)
        ..login.enable()
      )
      ..interface('g0/0/0', (x) => x
        ..operation.enable()
      )
      ..subinterface('g0/0/0.10', (x) => x
        ..encapsulateVlan(10)
        ..ip.setGateway(ipAddresses['R1']['g0/0/0.10'])
        ..operation.enable()
      )
      ..subinterface('g0/0/0.20', (x) => x
        ..encapsulateVlan(20)
        ..ip.setGateway(ipAddresses['R1']['g0/0/0.20'])
        ..operation.enable()
      )
      ..subinterface('g0/0/0.30', (x) => x
        ..encapsulateVlan(30)
        ..ip.setGateway(ipAddresses['R1']['g0/0/0.30'])
        ..operation.enable()
      )
      ..subinterface('g0/0/0.99', (x) => x
        ..encapsulateVlan(99)
        ..ip.setGateway(ipAddresses['R1']['g0/0/0.99'])
        ..operation.enable()
      )
      ..interface('g0/0/1', (x) => x
        ..ip.setGateway(ipAddresses['R1']['g0/0/1'])
        ..ipv6.enableSlaac()
        ..operation.enable()
      )
      ..ip.setDefaultRoute(ipAddresses['R1']['default-route'], 'g0/0/1')
      ..ipv6.setDefaultRoute(ipv6Addresses['R1']['default-route'], 'g0/0/1')
      ..ip.dhcp.excludeAddresses(
        ipAddresses['R1']['dhcp-A-exclusion-start'],
        ipAddresses['R1']['dhcp-A-exclusion-end']
      )
      ..ip.dhcp.excludeAddresses(
        ipAddresses['R1']['dhcp-B-exclusion-start'],
        ipAddresses['R1']['dhcp-B-exclusion-end']
      )
      ..ip.dhcp.excludeAddresses(
        ipAddresses['R1']['dhcp-C-exclusion-start'],
        ipAddresses['R1']['dhcp-C-exclusion-end']
      )
      ..ip.dhcp.excludeAddresses(
        ipAddresses['R1']['dhcp-F-exclusion'],
        ipAddresses['R1']['dhcp-F-exclusion']
      )
      ..ip.dhcp.pool('Student', (x) => x
        ..setNetworkAddress(subnets['A'])
        ..setDnsServer(ipAddresses['R1']['dns-server'])
      )
      ..ip.dhcp.pool('Faculty', (x) => x
        ..setNetworkAddress(subnets['B'])
        ..setDnsServer(ipAddresses['R1']['dns-server'])
      )
      ..ip.dhcp.pool('HR', (x) => x
        ..setNetworkAddress(subnets['C'])
        ..setDnsServer(ipAddresses['R1']['dns-server'])
      )
      ..ip.dhcp.pool('SubnetF', (x) => x
        ..setNetworkAddress(subnets['F'])
        ..setDnsServer(ipAddresses['R1']['dns-server'])
      )
    )
    ..saveConfig()
  );

  print('\n>>> R2 <<<\n');

  Device('router').enable((x) => x
    ..configure((x) => x
      ..setHostname('R2')
      ..ip.dnsLookup.disable()
      ..setMessageOfTheDay(motd)
      ..setConfigPassword(configPassword)
      ..services.passwordEncryption.enable()
      ..ip.setDomainName('ccna.com')
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
      ..ip.setDefaultRoute(ipAddresses['R2']['default-route'], 'g0/0/1')
      ..ipv6.setDefaultRoute(ipv6Addresses['R2']['default-route'], 'g0/0/1')
      ..ipv6.dhcp.pool('Stateful', (x) => x
        ..setDomainName('ccna.com')
        ..setDnsServer(ipv6Addresses['R2']['dhcp-dns-server'])
      )
    )
    ..saveConfig()
  );

  print('\n>>> S1 <<<\n');

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
      ..interfaces('f0/5-23, g0/1-2', (x) => x
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
        ..switchport.access.setVlan(10)
        ..spanningTree.portfast.enable()
        ..spanningTree.portfast.bpduGuard.enable()
        ..operation.enable()
      )
      ..interface('vlan 99', (x) => x
        ..ip.setGateway(ipAddresses['S1']['vlan 99'])
      )
      ..spanningTree.enableRapidPVST()
      ..spanningTree.setPriorityValueByOffset(10, -1)
    )
    ..saveConfig()
  );

  print('\n>>> S2 <<<\n');

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
      ..interfaces('f0/1-2, f0/7-22, g0/1-2', (x) => x
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
      ..interface('f0/23', (x) => x
        ..switchport.access.enable()
        ..switchport.access.setVlan(20)
        ..spanningTree.portfast.enable()
        ..spanningTree.portfast.bpduGuard.enable()
        ..operation.enable()
      )
      ..interface('f0/24', (x) => x
        ..switchport.access.enable()
        ..switchport.access.setVlan(30)
        ..spanningTree.portfast.enable()
        ..spanningTree.portfast.bpduGuard.enable()
        ..operation.enable()
      )
      ..interface('vlan 99', (x) => x
        ..ip.setGateway(ipAddresses['S2']['vlan 99'])
      )
      ..spanningTree.enableRapidPVST()
      ..spanningTree.setPriorityValueByOffset(20, -1)
    )
    ..saveConfig()
  );

  print('\n>>> S3 <<<\n');

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
      ..interfaces('f0/3-4, f0/7-24, g0/2', (x) => x
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

  print('\n>>> S4 <<<\n');

  Device('switch').enable((x) => x
    ..configure((x) => x
      ..setHostname('S4')
      ..ip.dnsLookup.disable()
      ..setMessageOfTheDay(motd)
    )
  );
}
