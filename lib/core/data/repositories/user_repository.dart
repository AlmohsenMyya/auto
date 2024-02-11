// import 'package:dartz/dartz.dart';
// import 'package:empty_project/core/data/models/apis/token_info.dart';
// import 'package:empty_project/core/data/models/common_response.dart';
// import 'package:empty_project/core/data/network/endpoints/user_endpoints.dart';
// import 'package:empty_project/core/data/network/network_config.dart';
// import 'package:empty_project/core/enums/request_type.dart';
// import 'package:empty_project/core/utils/network_util.dart';

// class UserRepository {
//   Future<Either<String, TokenInfo>> login({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       return NetworkUtil.sendRequest(
//         type: RequestType.POST,
//         url: UserEndPoints.login,
//         body: {
//           'userName': email,
//           'password': password,
//         },
//         headers: NetworkConfig.getHeaders(
//           needAuth: false,
//         ),
//       ).then((response) {
//         CommonResponse<Map<String, dynamic>> commonResponse =
//             CommonResponse.fromJson(response);

//         if (commonResponse.getStatus) {
//           return Right(TokenInfo.fromJson(commonResponse.data ?? {}));
//         } else {
//           return Left(commonResponse.message ?? '');
//         }
//       });
//     } catch (e) {
//       return Left(e.toString());
//     }
//   }

//   Future<Either<String, bool>> register({
//     required String email,
//     required String password,
//     required String firstname,
//     required String lastname,
//     required int age,
//     required String photoPath,
//   }) async {
//     try {
//       return NetworkUtil.sendMultipartRequest(
//         type: RequestType.POST,
//         url: UserEndPoints.register,
//         fields: {
//           'Email': email,
//           'FirstName': firstname,
//           'LastName': lastname,
//           'Password': password,
//           'Age': age.toString(),
//         },
//         files: {"Photo": photoPath},
//         headers:
//             NetworkConfig.getHeaders(needAuth: false, isMultipartRequest: true),
//       ).then((response) {
//         CommonResponse<Map<String, dynamic>> commonResponse =
//             CommonResponse.fromJson(response);

//         if (commonResponse.getStatus) {
//           return Right(commonResponse.getStatus);
//         } else {
//           return Left(commonResponse.message ?? '');
//         }
//       });
//     } catch (e) {
//       return Left(e.toString());
//     }
//   }
// }