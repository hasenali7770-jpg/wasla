// This is a generated file - do not edit.
//
// Generated from wasla/v1/contacts.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import 'common.pbjson.dart' as $1;
import 'users.pbjson.dart' as $0;

@$core.Deprecated('Use inputContactDescriptor instead')
const InputContact$json = {
  '1': 'InputContact',
  '2': [
    {'1': 'client_id', '3': 1, '4': 1, '5': 3, '10': 'clientId'},
    {'1': 'phone', '3': 2, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
  ],
};

/// Descriptor for `InputContact`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inputContactDescriptor = $convert.base64Decode(
    'CgxJbnB1dENvbnRhY3QSGwoJY2xpZW50X2lkGAEgASgDUghjbGllbnRJZBIUCgVwaG9uZRgCIA'
    'EoCVIFcGhvbmUSHQoKZmlyc3RfbmFtZRgDIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgE'
    'IAEoCVIIbGFzdE5hbWU=');

@$core.Deprecated('Use importedContactDescriptor instead')
const ImportedContact$json = {
  '1': 'ImportedContact',
  '2': [
    {'1': 'client_id', '3': 1, '4': 1, '5': 3, '10': 'clientId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 3, '10': 'userId'},
  ],
};

/// Descriptor for `ImportedContact`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importedContactDescriptor = $convert.base64Decode(
    'Cg9JbXBvcnRlZENvbnRhY3QSGwoJY2xpZW50X2lkGAEgASgDUghjbGllbnRJZBIXCgd1c2VyX2'
    'lkGAIgASgDUgZ1c2VySWQ=');

@$core.Deprecated('Use importContactsRequestDescriptor instead')
const ImportContactsRequest$json = {
  '1': 'ImportContactsRequest',
  '2': [
    {
      '1': 'contacts',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.InputContact',
      '10': 'contacts'
    },
  ],
};

/// Descriptor for `ImportContactsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importContactsRequestDescriptor = $convert.base64Decode(
    'ChVJbXBvcnRDb250YWN0c1JlcXVlc3QSMgoIY29udGFjdHMYASADKAsyFi53YXNsYS52MS5Jbn'
    'B1dENvbnRhY3RSCGNvbnRhY3Rz');

@$core.Deprecated('Use importContactsResponseDescriptor instead')
const ImportContactsResponse$json = {
  '1': 'ImportContactsResponse',
  '2': [
    {
      '1': 'imported',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.ImportedContact',
      '10': 'imported'
    },
    {
      '1': 'users',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.User',
      '10': 'users'
    },
    {'1': 'retry_client_ids', '3': 3, '4': 3, '5': 3, '10': 'retryClientIds'},
  ],
};

/// Descriptor for `ImportContactsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importContactsResponseDescriptor = $convert.base64Decode(
    'ChZJbXBvcnRDb250YWN0c1Jlc3BvbnNlEjUKCGltcG9ydGVkGAEgAygLMhkud2FzbGEudjEuSW'
    '1wb3J0ZWRDb250YWN0UghpbXBvcnRlZBIkCgV1c2VycxgCIAMoCzIOLndhc2xhLnYxLlVzZXJS'
    'BXVzZXJzEigKEHJldHJ5X2NsaWVudF9pZHMYAyADKANSDnJldHJ5Q2xpZW50SWRz');

@$core.Deprecated('Use listContactsRequestDescriptor instead')
const ListContactsRequest$json = {
  '1': 'ListContactsRequest',
  '2': [
    {'1': 'hash', '3': 1, '4': 1, '5': 3, '10': 'hash'},
  ],
};

/// Descriptor for `ListContactsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listContactsRequestDescriptor = $convert
    .base64Decode('ChNMaXN0Q29udGFjdHNSZXF1ZXN0EhIKBGhhc2gYASABKANSBGhhc2g=');

@$core.Deprecated('Use listContactsResponseDescriptor instead')
const ListContactsResponse$json = {
  '1': 'ListContactsResponse',
  '2': [
    {'1': 'not_modified', '3': 1, '4': 1, '5': 8, '10': 'notModified'},
    {
      '1': 'users',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.User',
      '10': 'users'
    },
    {'1': 'hash', '3': 3, '4': 1, '5': 3, '10': 'hash'},
  ],
};

/// Descriptor for `ListContactsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listContactsResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0Q29udGFjdHNSZXNwb25zZRIhCgxub3RfbW9kaWZpZWQYASABKAhSC25vdE1vZGlmaW'
    'VkEiQKBXVzZXJzGAIgAygLMg4ud2FzbGEudjEuVXNlclIFdXNlcnMSEgoEaGFzaBgDIAEoA1IE'
    'aGFzaA==');

@$core.Deprecated('Use deleteContactsRequestDescriptor instead')
const DeleteContactsRequest$json = {
  '1': 'DeleteContactsRequest',
  '2': [
    {'1': 'user_ids', '3': 1, '4': 3, '5': 3, '10': 'userIds'},
  ],
};

/// Descriptor for `DeleteContactsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteContactsRequestDescriptor =
    $convert.base64Decode(
        'ChVEZWxldGVDb250YWN0c1JlcXVlc3QSGQoIdXNlcl9pZHMYASADKANSB3VzZXJJZHM=');

@$core.Deprecated('Use deleteContactsResponseDescriptor instead')
const DeleteContactsResponse$json = {
  '1': 'DeleteContactsResponse',
};

/// Descriptor for `DeleteContactsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteContactsResponseDescriptor =
    $convert.base64Decode('ChZEZWxldGVDb250YWN0c1Jlc3BvbnNl');

const $core.Map<$core.String, $core.dynamic> ContactsServiceBase$json = {
  '1': 'ContactsService',
  '2': [
    {
      '1': 'ImportContacts',
      '2': '.wasla.v1.ImportContactsRequest',
      '3': '.wasla.v1.ImportContactsResponse'
    },
    {
      '1': 'ListContacts',
      '2': '.wasla.v1.ListContactsRequest',
      '3': '.wasla.v1.ListContactsResponse'
    },
    {
      '1': 'DeleteContacts',
      '2': '.wasla.v1.DeleteContactsRequest',
      '3': '.wasla.v1.DeleteContactsResponse'
    },
  ],
};

@$core.Deprecated('Use contactsServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    ContactsServiceBase$messageJson = {
  '.wasla.v1.ImportContactsRequest': ImportContactsRequest$json,
  '.wasla.v1.InputContact': InputContact$json,
  '.wasla.v1.ImportContactsResponse': ImportContactsResponse$json,
  '.wasla.v1.ImportedContact': ImportedContact$json,
  '.wasla.v1.User': $0.User$json,
  '.wasla.v1.Avatar': $1.Avatar$json,
  '.wasla.v1.UserStatus': $0.UserStatus$json,
  '.wasla.v1.Online': $0.Online$json,
  '.wasla.v1.ListContactsRequest': ListContactsRequest$json,
  '.wasla.v1.ListContactsResponse': ListContactsResponse$json,
  '.wasla.v1.DeleteContactsRequest': DeleteContactsRequest$json,
  '.wasla.v1.DeleteContactsResponse': DeleteContactsResponse$json,
};

/// Descriptor for `ContactsService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List contactsServiceDescriptor = $convert.base64Decode(
    'Cg9Db250YWN0c1NlcnZpY2USUwoOSW1wb3J0Q29udGFjdHMSHy53YXNsYS52MS5JbXBvcnRDb2'
    '50YWN0c1JlcXVlc3QaIC53YXNsYS52MS5JbXBvcnRDb250YWN0c1Jlc3BvbnNlEk0KDExpc3RD'
    'b250YWN0cxIdLndhc2xhLnYxLkxpc3RDb250YWN0c1JlcXVlc3QaHi53YXNsYS52MS5MaXN0Q2'
    '9udGFjdHNSZXNwb25zZRJTCg5EZWxldGVDb250YWN0cxIfLndhc2xhLnYxLkRlbGV0ZUNvbnRh'
    'Y3RzUmVxdWVzdBogLndhc2xhLnYxLkRlbGV0ZUNvbnRhY3RzUmVzcG9uc2U=');
