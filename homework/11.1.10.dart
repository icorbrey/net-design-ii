import 'package:cisco_ios_dsl/cisco_ios_dsl.dart';

void run() {
  Device.script('S1').enable((x) => x
    ..configure((x) => x
      ..interfaces('f0/1-2', (x) => x
        ..switchport.portSecurity.enable()
        ..switchport.portSecurity.setMaxDevices(1)
        ..switchport.portSecurity.rememberMacAddresses()
        ..switchport.portSecurity.logViolations()
        ..operation.enable()
      )
      ..interfaces('f0/3-24, g0/1-2', (x) => x
        ..operation.disable()
      )
    )
  );
}
