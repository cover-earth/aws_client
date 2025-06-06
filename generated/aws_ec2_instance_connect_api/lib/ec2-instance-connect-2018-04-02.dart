// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name

import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_aws_api/shared.dart' as _s;
import 'package:shared_aws_api/shared.dart'
    show
        rfc822ToJson,
        iso8601ToJson,
        unixTimestampToJson,
        nonNullableTimeStampFromJson,
        timeStampFromJson;

export 'package:shared_aws_api/shared.dart' show AwsClientCredentials;

/// AWS EC2 Connect Service is a service that enables system administrators to
/// publish temporary SSH keys to their EC2 instances in order to establish
/// connections to their instances without leaving a permanent authentication
/// option.
class EC2InstanceConnect {
  final _s.JsonProtocol _protocol;
  EC2InstanceConnect({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.AwsClientCredentialsProvider? credentialsProvider,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.JsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'ec2-instance-connect',
          ),
          region: region,
          credentials: credentials,
          credentialsProvider: credentialsProvider,
          endpointUrl: endpointUrl,
        );

  /// Closes the internal HTTP client if none was provided at creation.
  /// If a client was passed as a constructor argument, this becomes a noop.
  ///
  /// It's important to close all clients when it's done being used; failing to
  /// do so can cause the Dart process to hang.
  void close() {
    _protocol.close();
  }

  /// Pushes an SSH public key to a particular OS user on a given EC2 instance
  /// for 60 seconds.
  ///
  /// May throw [AuthException].
  /// May throw [InvalidArgsException].
  /// May throw [ServiceException].
  /// May throw [ThrottlingException].
  /// May throw [EC2InstanceNotFoundException].
  ///
  /// Parameter [availabilityZone] :
  /// The availability zone the EC2 instance was launched in.
  ///
  /// Parameter [instanceId] :
  /// The EC2 instance you wish to publish the SSH key to.
  ///
  /// Parameter [instanceOSUser] :
  /// The OS user on the EC2 instance whom the key may be used to authenticate
  /// as.
  ///
  /// Parameter [sSHPublicKey] :
  /// The public key to be published to the instance. To use it after
  /// publication you must have the matching private key.
  Future<SendSSHPublicKeyResponse> sendSSHPublicKey({
    required String availabilityZone,
    required String instanceId,
    required String instanceOSUser,
    required String sSHPublicKey,
  }) async {
    ArgumentError.checkNotNull(availabilityZone, 'availabilityZone');
    _s.validateStringLength(
      'availabilityZone',
      availabilityZone,
      6,
      32,
      isRequired: true,
    );
    ArgumentError.checkNotNull(instanceId, 'instanceId');
    _s.validateStringLength(
      'instanceId',
      instanceId,
      10,
      32,
      isRequired: true,
    );
    ArgumentError.checkNotNull(instanceOSUser, 'instanceOSUser');
    _s.validateStringLength(
      'instanceOSUser',
      instanceOSUser,
      1,
      32,
      isRequired: true,
    );
    ArgumentError.checkNotNull(sSHPublicKey, 'sSHPublicKey');
    _s.validateStringLength(
      'sSHPublicKey',
      sSHPublicKey,
      256,
      4096,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSEC2InstanceConnectService.SendSSHPublicKey'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AvailabilityZone': availabilityZone,
        'InstanceId': instanceId,
        'InstanceOSUser': instanceOSUser,
        'SSHPublicKey': sSHPublicKey,
      },
    );

    return SendSSHPublicKeyResponse.fromJson(jsonResponse.body);
  }
}

class SendSSHPublicKeyResponse {
  /// The request ID as logged by EC2 Connect. Please provide this when contacting
  /// AWS Support.
  final String? requestId;

  /// Indicates request success.
  final bool? success;

  SendSSHPublicKeyResponse({
    this.requestId,
    this.success,
  });
  factory SendSSHPublicKeyResponse.fromJson(Map<String, dynamic> json) {
    return SendSSHPublicKeyResponse(
      requestId: json['RequestId'] as String?,
      success: json['Success'] as bool?,
    );
  }
}

class AuthException extends _s.GenericAwsException {
  AuthException({String? type, String? message})
      : super(type: type, code: 'AuthException', message: message);
}

class EC2InstanceNotFoundException extends _s.GenericAwsException {
  EC2InstanceNotFoundException({String? type, String? message})
      : super(
            type: type, code: 'EC2InstanceNotFoundException', message: message);
}

class InvalidArgsException extends _s.GenericAwsException {
  InvalidArgsException({String? type, String? message})
      : super(type: type, code: 'InvalidArgsException', message: message);
}

class ServiceException extends _s.GenericAwsException {
  ServiceException({String? type, String? message})
      : super(type: type, code: 'ServiceException', message: message);
}

class ThrottlingException extends _s.GenericAwsException {
  ThrottlingException({String? type, String? message})
      : super(type: type, code: 'ThrottlingException', message: message);
}

final _exceptionFns = <String, _s.AwsExceptionFn>{
  'AuthException': (type, message) =>
      AuthException(type: type, message: message),
  'EC2InstanceNotFoundException': (type, message) =>
      EC2InstanceNotFoundException(type: type, message: message),
  'InvalidArgsException': (type, message) =>
      InvalidArgsException(type: type, message: message),
  'ServiceException': (type, message) =>
      ServiceException(type: type, message: message),
  'ThrottlingException': (type, message) =>
      ThrottlingException(type: type, message: message),
};
