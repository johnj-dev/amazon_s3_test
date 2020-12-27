import 'dart:io';

import 'package:flutter_aws_s3_client/flutter_aws_s3_client.dart';
import 'package:amazon_s3_test/constants.dart';
import 'package:dio/dio.dart';

class Policy {

  void getPicture() async {
    const region = DO_SPACES_REGION;
    const bucketId = DO_SPACES_BUCKET;
    final AwsS3Client s3client = AwsS3Client(
        region: region,
        host: "$bucketId.$region.digitaloceanspaces.com",
        bucketId: '',
        accessKey: "$DO_SPACES_KEY",
        secretKey: "$DO_SPACES_KEY",
        sessionToken: "$DO_SPACES_TOKEN"
    );

    final key =
        '$DO_SPACES_ROOT/'
        '0e3b82e8-cb7a-49ca-9b19-2b0930f73f55/'
        'types/thumbnails/'
        '1608021840_ENcOJOd8XrzPGHW2y97If8kYUuhOcLTLjfOheRXS.webp';

    final signedParams = s3client.buildSignedGetParams(key: key);
    //final headers = signedParams.headers
    final headers = signedParams.headers.toString().split(',');
    for(var i in headers) {
      print(i);
    }
    print(signedParams.headers['x-amz-content-sha256']);
    print('${headers[2].substring(headers[2].indexOf('=')+1)}');
    print('${headers[0].substring(headers[0].indexOf('=')+1)}');
    final url = Uri.https("$bucketId.$region.digitaloceanspaces.com", '$key', {
      'X-Amz-Content-Sha256':'${signedParams.headers['x-amz-content-sha256']}',
      'X-Amz-Algorithm':'AWS4-HMAC-SHA256',
      'X-Amz-Credential':'${headers[0].substring(headers[0].indexOf('=')+1)}',
      'X-Amz-Date':'${signedParams.headers['x-amz-date']}',
      'X-Amz-SignedHeaders':'host',
      'X-Amz-Expires':'43200',
      'X-Amz-Signature':'${headers[2].substring(headers[2].indexOf('=')+1)}',
    });
    print(url);
    final dio = Dio();
    final response = await dio.get(url.toString());
    print(response.realUri);
    print(response.statusCode);




    // final request = await HttpClient().getUrl(signedParams.uri, );
    //
    // for (final header in (signedParams.headers ?? const {}).entries) {
    //   request.headers.add(header.key, header.value);
    // }
    // // if(eTag != null){
    // //     //   request.headers.add(HttpHeaders.ifNoneMatchHeader, eTag);
    // //     // }
    // final response = await request.close();
    // if(response.statusCode != HttpStatus.ok) {
    //   //handle error
    //   print(response.statusCode);
    // } else {
    //   print('IT WORKED!');
    // }
    // }else{
    //   return response.pipe(file.openWrite());
    // }

    // final listBucketResult =
    // await s3client.listObjects(prefix: "/", delimiter: "/");
    // print(listBucketResult.toString());
    //
    // final response = await s3client.getObject("yourObjectId");
    // print(response.body.toString());
  }
}
