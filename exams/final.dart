import 'package:cisco_ios_dsl/cisco_ios_dsl.dart';

void run() {

  var messageOfTheDay = 'Unauthorized access is strictly prohibited.';

  var domain = 'ccnalab.com';

  var password_config = 'Cisco';
  var password_remote = 'Remote';
  var password_console = 'Class';

  var vlan_10_name = 'Engineering';
  var vlan_20_name = 'Finance';
  var vlan_30_name = 'Marketing';
  var vlan_40_name = 'Management';

  var default_route = IPv4.fromMask('0.0.0.0', '0.0.0.0');

  var network_a = IPv4.fromCidr('192.168.1.0', 24);
  var network_b = IPv4.fromCidr('192.168.2.0', 24);
  var network_c = IPv4.fromCidr('192.168.3.0', 24);
  var network_d = IPv4.fromCidr('192.168.4.0', 24);
  var network_e = IPv4.fromCidr('10.10.10.0', 30);
  var network_f = IPv4.fromCidr('10.10.10.4', 30);
  var network_g = IPv4.fromCidr('10.10.10.8', 30);
  var network_h = IPv4.fromCidr('10.10.10.12', 30);
  var network_i = IPv4.fromCidr('10.10.10.16', 30);
  var network_j = IPv4.fromCidr('172.16.21.0', 24);

  var network_abcd_summary = IPv4.fromCidr('192.168.0.0', 21);

  var trunk_vlans = [10, 20, 30, 40];

  print('>>> R1 <<<\n');

  Device('router').enable((x) => x
    ..configure((x) => x
      ..setHostname('R1')
      ..ipv4.dnsLookup.disable()
      ..ipv4.setDomainName(domain)
      ..setConfigPassword(password_config)
      ..setMessageOfTheDay(messageOfTheDay)
      ..services.passwordEncryption.enable()
      ..line('console 0', (x) => x
        ..password.enable(password_console)
      )
      ..line('vty 0 15', (x) => x
        ..password.enable(password_remote)
        ..transport.input.enable('ssh')
        ..login.setType('local')
      )
      ..interface('g0/0/0', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..enable()
      )
      ..subinterface('g0/0/0.10', (x) => x
        ..encapsulateVlan(10)
        ..ipv4.setGateway(network_a)
        ..hsrp.enable()
        ..hsrp.setStandbyGatewayForGroup(1, network_a)
        ..hsrp.setStandbyRouterPriority(1, 100)
        ..enable()
      )
      ..subinterface('g0/0/0.20', (x) => x
        ..encapsulateVlan(20)
        ..ipv4.setGateway(network_b)
        ..hsrp.enable()
        ..hsrp.setStandbyGatewayForGroup(1, network_b)
        ..hsrp.setStandbyRouterPriority(1, 100)
        ..enable()
      )
      ..subinterface('g0/0/0.30', (x) => x
        ..encapsulateVlan(30)
        ..ipv4.setGateway(network_c)
        ..hsrp.enable()
        ..hsrp.setStandbyGatewayForGroup(1, network_c)
        ..hsrp.setStandbyRouterPriority(1, 100)
        ..enable()
      )
      ..subinterface('g0/0/0.40', (x) => x
        ..encapsulateVlan(40)
        ..ipv4.setGateway(network_d)
        ..hsrp.enable()
        ..hsrp.setStandbyGatewayForGroup(1, network_d)
        ..hsrp.setStandbyRouterPriority(1, 100)
        ..enable()
      )
      ..interface('g0/0/1', (x) => x
        ..ipv4.setGateway(network_e)
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..enable()
      )
      ..ipv4.routing.enable()
      ..ipv4.routing.createStaticDefaultRoute(network_j)
      ..ipv4.routing.createFullySpecifiedStaticRoute(default_route, network_e, 'g0/0/1')
    )
    ..saveConfig()
  );

  print('\n>>> R2 <<<\n');

  Device('router').enable((x) => x
    ..configure((x) => x
      ..setHostname('R2')
      ..ipv4.dnsLookup.disable()
      ..ipv4.setDomainName(domain)
      ..setConfigPassword(password_config)
      ..setMessageOfTheDay(messageOfTheDay)
      ..services.passwordEncryption.enable()
      ..line('console 0', (x) => x
        ..password.enable(password_console)
      )
      ..line('vty 0 15', (x) => x
        ..password.enable(password_remote)
        ..transport.input.enable('ssh')
        ..login.setType('local')
      )
      ..interface('g0/0/0', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..enable()
      )
      ..subinterface('g0/0/0.10', (x) => x
        ..encapsulateVlan(10)
        ..ipv4.setGateway(network_a)
        ..hsrp.enable()
        ..hsrp.setStandbyGatewayForGroup(1, network_a)
        ..hsrp.setStandbyRouterPriority(1, 150)
        ..hsrp.allowPrimaryRouterToRetakeControl(1)
        ..enable()
      )
      ..subinterface('g0/0/0.20', (x) => x
        ..encapsulateVlan(20)
        ..ipv4.setGateway(network_b)
        ..hsrp.enable()
        ..hsrp.setStandbyGatewayForGroup(1, network_b)
        ..hsrp.setStandbyRouterPriority(1, 150)
        ..hsrp.allowPrimaryRouterToRetakeControl(1)
        ..enable()
      )
      ..subinterface('g0/0/0.30', (x) => x
        ..encapsulateVlan(30)
        ..ipv4.setGateway(network_c)
        ..hsrp.enable()
        ..hsrp.setStandbyGatewayForGroup(1, network_c)
        ..hsrp.setStandbyRouterPriority(1, 150)
        ..hsrp.allowPrimaryRouterToRetakeControl(1)
        ..enable()
      )
      ..subinterface('g0/0/0.40', (x) => x
        ..encapsulateVlan(40)
        ..ipv4.setGateway(network_d)
        ..hsrp.enable()
        ..hsrp.setStandbyGatewayForGroup(1, network_d)
        ..hsrp.setStandbyRouterPriority(1, 150)
        ..hsrp.allowPrimaryRouterToRetakeControl(1)
        ..enable()
      )
      ..interface('g0/0/1', (x) => x
        ..ipv4.setGateway(network_f)
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..enable()
      )
      ..interface('s0/1/0', (x) => x
        ..ipv4.setGateway(network_g)
        ..enable()
      )
      ..ipv4.routing.enable()
      ..ipv4.routing.createStaticDefaultRoute(network_j)
      ..ipv4.routing.createStaticFloatingRoute(network_j, network_f, 5)
    )
    ..saveConfig()
  );
  
  print('\n>>> R3 <<<\n');

  Device('router').enable((x) => x
    ..configure((x) => x
      ..setHostname('R3')
      ..ipv4.dnsLookup.disable()
      ..ipv4.setDomainName(domain)
      ..setConfigPassword(password_config)
      ..setMessageOfTheDay(messageOfTheDay)
      ..services.passwordEncryption.enable()
      ..line('console 0', (x) => x
        ..password.enable(password_console)
      )
      ..line('vty 0 15', (x) => x
        ..password.enable(password_remote)
        ..transport.input.enable('ssh')
        ..login.setType('local')
      )
      ..interface('g0/0/0', (x) => x
        ..ipv4.setGateway(network_j)
        ..ipv6.addGateway(IPv6.fromCidr('2001:db8:acad:1::', 64))
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..enable()
      )
      ..interface('g0/0/1', (x) => x
        ..ipv4.setGateway(network_i)
        ..ipv6.addGateway(IPv6.fromCidr('2001:db8:acad:2::', 64))
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..enable()
      )
      ..ipv4.routing.enable()
      ..ipv4.routing.createStaticDefaultRoute(network_j)
      ..ipv4.routing.createRecursiveStaticRoute(network_abcd_summary, network_j)
      ..ipv6.routing.enable()
      ..ipv6.routing.createStaticDefaultRoute(IPv6.fromCidr('::', 64), IPv6.fromCidr('::', 64))
    )
    ..saveConfig()
  );
  
  print('\n>>> R4 <<<\n');

  Device('router').enable((x) => x
    ..configure((x) => x
      ..setHostname('R4')
      ..ipv4.dnsLookup.disable()
      ..ipv4.setDomainName(domain)
      ..setConfigPassword(password_config)
      ..setMessageOfTheDay(messageOfTheDay)
      ..services.passwordEncryption.enable()
      ..line('console 0', (x) => x
        ..password.enable(password_console)
      )
      ..line('vty 0 15', (x) => x
        ..password.enable(password_remote)
        ..transport.input.enable('ssh')
        ..login.setType('local')
      )
      ..interface('g0/0/0', (x) => x
        ..ipv4.setGateway(network_e)
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..enable()
      )
      ..interface('g0/0/1', (x) => x
        ..ipv4.setGateway(network_i)
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..enable()
      )
      ..interface('s0/1/0', (x) => x
        ..ipv4.setGateway(network_f)
        ..enable()
      )
      ..interface('s0/1/1', (x) => x
        ..ipv4.setGateway(network_h)
        ..enable()
      )
      ..ipv4.routing.enable()
      ..ipv4.routing.createStaticDefaultRoute(network_j)
      ..ipv4.routing.createStaticFloatingRoute(network_j, network_f, 5)
      ..ipv6.routing.enable()
      ..ipv6.routing.createStaticDefaultRoute(IPv6.fromCidr('::', 64), IPv6.fromCidr('::', 64))
    )
    ..saveConfig()
  );
  
  print('\n>>> ISP <<<\n');
  
  Device('router').enable((x) => x
    ..configure((x) => x
      ..setHostname('ISP')
      ..interface('s0/1/0', (x) => x
        ..ipv4.setGateway(network_h)
        ..enable()
      ) 
      ..interface('s0/1/1', (x) => x
        ..ipv4.setGateway(network_g)
        ..enable()
      ) 
      ..interface('loop0', (x) => x
        ..ipv4.setGateway(IPv4.fromCidr('193.45.28.0', 30))
        ..enable()
      )
      ..ipv4.routing.enable()
      ..ipv4.routing.createStaticDefaultRoute(network_j)
      ..ipv4.routing.createStaticDefaultInterfaceRoute('loop0')
    )
    ..saveConfig()
  );
  
  print('\n>>> S1 <<<\n');
  
  Device('switch').enable((x) => x
    ..configure((x) => x
      ..setHostname('S1')
      ..ipv4.dnsLookup.disable()
      ..setConfigPassword(password_config)
      ..setMessageOfTheDay(messageOfTheDay)
      ..services.passwordEncryption.enable()
      ..vlan(10, (x) => x
        ..setName(vlan_10_name)
      )
      ..vlan(20, (x) => x
        ..setName(vlan_20_name)
      )
      ..vlan(30, (x) => x
        ..setName(vlan_30_name)
      )
      ..vlan(40, (x) => x
        ..setName(vlan_40_name)
      )
      ..line('console 0', (x) => x
        ..password.enable(password_console)
      )
      ..line('vty 0 15', (x) => x
        ..password.enable(password_remote)
        ..transport.input.enable('ssh')
        ..login.setType('local')
      )
      ..interface('vlan 40', (x) => x
        ..ipv4.setGateway(network_d)
        ..enable()
      )
      ..interface('f0/1', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..etherChannel.enablePAgP(1)
        ..enable()
      )
      ..interface('f0/2', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..etherChannel.enablePAgP(1)
        ..enable()
      )
      ..interface('f0/3', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..etherChannel.enablePAgP(2)
        ..enable()
      )
      ..interface('f0/4', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..etherChannel.enablePAgP(2)
        ..enable()
      )
      ..interface('f0/5', (x) => x
        ..switchport.access.enable()
        ..spanningTree.portfast.enable()
        ..spanningTree.portfast.bpduGuard.enable()
        ..enable()
      )
      ..interfaces('f0/6-23', (x) => x
        ..disable()
      )
      ..interface('f0/24', (x) => x
        ..switchport.access.enable()
        ..switchport.access.setVlan(10)
        ..spanningTree.portfast.enable()
        ..spanningTree.portfast.bpduGuard.enable()
        ..enable()
      )
      ..spanningTree.enableRapidPVST()
      ..spanningTree.setPriorityValueByOffset(20, -1)
    )
    ..saveConfig()
  );
  
  print('\n>>> S2 <<<\n');
  
  Device('switch').enable((x) => x
    ..configure((x) => x
      ..setHostname('S2')
      ..ipv4.dnsLookup.disable()
      ..setConfigPassword(password_config)
      ..setMessageOfTheDay(messageOfTheDay)
      ..services.passwordEncryption.enable()
      ..vlan(10, (x) => x
        ..setName(vlan_10_name)
      )
      ..vlan(20, (x) => x
        ..setName(vlan_20_name)
      )
      ..vlan(30, (x) => x
        ..setName(vlan_30_name)
      )
      ..vlan(40, (x) => x
        ..setName(vlan_40_name)
      )
      ..line('console 0', (x) => x
        ..password.enable(password_console)
      )
      ..line('vty 0 15', (x) => x
        ..password.enable(password_remote)
        ..transport.input.enable('ssh')
        ..login.setType('local')
      )
      ..interface('vlan 40', (x) => x
        ..ipv4.setGateway(network_d)
        ..enable()
      )
      ..interface('g0/1', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..enable()
      )
      ..interfaces('f0/1-2', (x) => x
        ..disable()
      )
      ..interface('f0/3', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..etherChannel.enablePAgP(2)
        ..enable()
      )
      ..interface('f0/4', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..etherChannel.enablePAgP(2)
        ..enable()
      )
      ..interface('f0/5', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..etherChannel.enablePAgP(3)
        ..enable()
      )
      ..interface('f0/6', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..etherChannel.enablePAgP(3)
        ..enable()
      )
      ..interfaces('f0/7-21', (x) => x
        ..disable()
      )
      ..interface('f0/22', (x) => x
        ..switchport.access.enable()
        ..switchport.access.setVlan(30)
        ..spanningTree.portfast.enable()
        ..spanningTree.portfast.bpduGuard.enable()
        ..enable()
      )
      ..interface('f0/23', (x) => x
        ..switchport.access.enable()
        ..switchport.access.setVlan(20)
        ..spanningTree.portfast.enable()
        ..spanningTree.portfast.bpduGuard.enable()
        ..enable()
      )
      ..spanningTree.enableRapidPVST()
      ..spanningTree.setPriorityValueByOffset(30, -1)
    )
    ..saveConfig()
  );
  
  print('\n>>> S3 <<<\n');
  
  Device('switch').enable((x) => x
    ..configure((x) => x
      ..setHostname('S3')
      ..ipv4.dnsLookup.disable()
      ..setConfigPassword(password_config)
      ..setMessageOfTheDay(messageOfTheDay)
      ..services.passwordEncryption.enable()
      ..vlan(10, (x) => x
        ..setName(vlan_10_name)
      )
      ..vlan(20, (x) => x
        ..setName(vlan_20_name)
      )
      ..vlan(30, (x) => x
        ..setName(vlan_30_name)
      )
      ..vlan(40, (x) => x
        ..setName(vlan_40_name)
      )
      ..line('console 0', (x) => x
        ..password.enable(password_console)
      )
      ..line('vty 0 15', (x) => x
        ..password.enable(password_remote)
        ..transport.input.enable('ssh')
        ..login.setType('local')
      )
      ..interface('vlan 40', (x) => x
        ..ipv4.setGateway(network_d)
        ..enable()
      )
      ..interface('g0/1', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..enable()
      )
      ..interface('f0/1', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..etherChannel.enablePAgP(1)
        ..enable()
      )
      ..interface('f0/2', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..etherChannel.enablePAgP(1)
        ..enable()
      )
      ..interfaces('f0/3-4', (x) => x
        ..disable()
      )
      ..interface('f0/5', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..etherChannel.enablePAgP(3)
        ..enable()
      )
      ..interface('f0/6', (x) => x
        ..switchport.trunk.enable()
        ..switchport.trunk.setAllowedVlans(trunk_vlans)
        ..etherChannel.enablePAgP(3)
        ..enable()
      )
      ..interfaces('f0/7-24', (x) => x
        ..disable()
      )
      ..spanningTree.enableRapidPVST()
      ..spanningTree.setPriorityValueByOffset(10, -1)
    )
    ..saveConfig()
  );
  
  print('\n>>> S4 <<<\n');
  
  Device('switch').enable((x) => x
    ..configure((x) => x
      ..setHostname('S4')
      ..ipv4.dnsLookup.disable()
      ..setConfigPassword(password_config)
      ..setMessageOfTheDay(messageOfTheDay)
      ..services.passwordEncryption.enable()
      ..vlan(10, (x) => x
        ..setName(vlan_10_name)
      )
      ..vlan(20, (x) => x
        ..setName(vlan_20_name)
      )
      ..vlan(30, (x) => x
        ..setName(vlan_30_name)
      )
      ..vlan(40, (x) => x
        ..setName(vlan_40_name)
      )
      ..line('console 0', (x) => x
        ..password.enable(password_console)
      )
      ..line('vty 0 15', (x) => x
        ..password.enable(password_remote)
        ..transport.input.enable('telnet')
        ..login.setType('local')
      )
      ..interface('vlan 10', (x) => x
        ..ipv4.setGateway(network_j)
        ..enable()
      )
    )
    ..saveConfig()
  );
}
