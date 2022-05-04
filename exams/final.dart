import 'package:cisco_ios_dsl/cisco_ios_dsl.dart';

void run() {

  var messageOfTheDay = 'Unauthorized access is strictly prohibited.';

  var password_config = 'Cisco';
  var password_remote = 'Remote';
  var password_console = 'Class';

  var vlan_10_name = 'Engineering';
  var vlan_20_name = 'Finance';
  var vlan_30_name = 'Marketing';
  var vlan_40_name = 'Management';

  print('>>> R1 <<<\n');

  Device('router').enable((x) => x
    ..configure((x) => x
      ..setHostname('R1')
    )
  );

  print('\n>>> R2 <<<\n');

  Device('router').enable((x) => x
    ..configure((x) => x
      ..setHostname('R2')
    )
  );
  
  print('\n>>> R3 <<<\n');

  Device('router').enable((x) => x
    ..configure((x) => x
      ..setHostname('R3')
    )
  );
  
  print('\n>>> R4 <<<\n');

  Device('router').enable((x) => x
    ..configure((x) => x
      ..setHostname('R4')
    )
  );
  
  print('\n>>> ISP <<<\n');
  
  Device('router').enable((x) => x
    ..configure((x) => x
      ..setHostname('ISP')
    )
  );
  
  print('\n>>> S1 <<<\n');
  
  Device('switch').enable((x) => x
    ..configure((x) => x
      ..setHostname('S1')
      ..setConfigPassword(password_config)
      ..setMessageOfTheDay(messageOfTheDay)
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
    )
  );
  
  print('\n>>> S2 <<<\n');
  
  Device('switch').enable((x) => x
    ..configure((x) => x
      ..setHostname('S2')
      ..setConfigPassword(password_config)
      ..setMessageOfTheDay(messageOfTheDay)
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
    )
  );
  
  print('\n>>> S3 <<<\n');
  
  Device('switch').enable((x) => x
    ..configure((x) => x
      ..setHostname('S3')
      ..setConfigPassword(password_config)
      ..setMessageOfTheDay(messageOfTheDay)
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
    )
  );
  
  print('\n>>> S4 <<<\n');
  
  Device('switch').enable((x) => x
    ..configure((x) => x
      ..setHostname('S4')
      ..setConfigPassword(password_config)
      ..setMessageOfTheDay(messageOfTheDay)
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
    )
  );
}
