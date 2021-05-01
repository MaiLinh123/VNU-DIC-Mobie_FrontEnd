
// final _backendIp = '192.168.2.103';
final _backendIp = '192.168.0.115';
// final _backendIp = '192.168.1.114';
// final _backendIp = '192.168.43.200';

final _backendPort = 3333;

final _api = 'http://$_backendIp:$_backendPort/api';

final signInApi = '$_api/auth/signin';

final signUpApi = '$_api/auth/signup';

final userApi = '$_api/user/current';

final wordApi = '$_api/word/query/';

final saveWordApi = '$_api/word/user-words';