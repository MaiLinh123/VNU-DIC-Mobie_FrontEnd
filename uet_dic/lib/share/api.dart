
final backendIp = '192.168.2.103';

final backendPort = 3333;

final api = 'http://$backendIp:$backendPort/api';

final signInApi = '$api/auth/signin';

final signUpApi = '$api/auth/signup';

final userApi = '$api/user/current';