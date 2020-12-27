import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

class Policy {

  Future<File> getPicture() async {
    // const _awsUserPoolId = 'ap-southeast-1_xxxxxxxx';
    // const _awsClientId = 'xxxxxxxxxxxxxxxxxxxxxxxxxx';
    //
    // const _identityPoolId =
    //     'ap-southeast-1:xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx';
    // final _userPool = CognitoUserPool(_awsUserPoolId, _awsClientId);
    //
    // final _cognitoUser = CognitoUser('+60100000000', _userPool);
    // final authDetails =
    // AuthenticationDetails(username: '+60100000000', password: 'p@ssW0rd');
    //
    // CognitoUserSession _session;
    // try {
    //   _session = await _cognitoUser.authenticateUser(authDetails);
    // } catch (e) {
    //   print(e);
    //   return null;
    // }
    //
    // final _credentials = CognitoCredentials(_identityPoolId, _userPool);
    // await _credentials.getAwsCredentials(_session.getIdToken().getJwtToken());

    final bucketName = 'pdpe';
    final host = '$bucketName.sgp1.digitaloceanspaces.com';
    final region = 'sgp1';
    final service = 's3';

    final key =
        '$DO_SPACES_ROOT/'
        '0e3b82e8-cb7a-49ca-9b19-2b0930f73f55/'
        'types/thumbnails/'
        '1608021840_ENcOJOd8XrzPGHW2y97If8kYUuhOcLTLjfOheRXS.webp';
    final payload = SigV4.hashCanonicalRequest('');
    print(payload);
    final datetime = SigV4.generateDatetime();
    print('TESTT =============');
    print('${'/$key'.split('/').map((s) => Uri.encodeComponent(s)).join('/')}');
    final canonicalRequest = '''GET
${'/$key'.split('/').map((s) => Uri.encodeComponent(s)).join('/')}

host:$host
x-amz-content-sha256:$payload
x-amz-date:$datetime

host;x-amz-content-sha256;x-amz-date
$payload''';
    print('CANONICAL===========');
    print(canonicalRequest);

    final credentialScope =
    SigV4.buildCredentialScope(datetime, region, service);
    print('CREDENTIAL SCOPE ========');
    print('$DO_SPACES_KEY/$credentialScope');
    final stringToSign = SigV4.buildStringToSign(datetime, credentialScope,
        SigV4.hashCanonicalRequest(canonicalRequest));
    final signingKey = SigV4.calculateSigningKey(
        DO_SPACES_SECRET, datetime, region, service);
    final signature = SigV4.calculateSignature(signingKey, stringToSign);

    final authorization = [
      'AWS4-HMAC-SHA256 Credential=$DO_SPACES_KEY/$credentialScope',
      'SignedHeaders=host;x-amz-content-sha256;x-amz-date;x-amz-security-token',
      'Signature=$signature',
    ].join(',');

    var params = {
      'X-Amz-Content-Sha256':'UNSIGNED-PAYLOAD',
      'X-Amz-Algorithm':'AWS4-HMAC-SHA256',
      'X-Amz-Credential':'$DO_SPACES_KEY/$credentialScope',
      'X-Amz-Date':'$datetime',
      'X-Amz-SignedHeaders':'host',
      'X-Amz-Expires':'43200',
      'X-Amz-Signature':signature
    };
    final uri = Uri.https(host, key, params);
    print('URI===================');
    print(uri);
    http.Response response;
    response = await http.get(uri);
    // response = await http.get(uri, headers: {
    //   'Authorization': authorization,
    //   'x-amz-content-sha256': payload,
    //   'x-amz-date': datetime,
    // });
    try {

    } catch (e) {
      print(e);
      return null;
    }
    print(response.statusCode);

    // final file = File(path.join(
    //     '/path/to/my/folder',
    //     'square-cinnamon-downloaded.jpg'));
    //
    // try {
    //   await file.writeAsBytes(response.bodyBytes);
    //   return file;
    // } catch (e) {
    //   print(e.toString());
    //   return null;
    // }

    print('complete!');
  }
}