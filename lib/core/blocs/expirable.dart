import 'package:exchange/app+injection/di.dart';
import 'package:exchange/core/error/http/forbidden_error.dart';
import 'package:exchange/core/result/result.dart';

// abstract class Expirable {
//   void expire(Result result) {
//     if (result.hasErrorOnly && result.error is ForbiddenError) {
//       locator<AuthBloc>().logout();
//     }
//     return;
//   }
// }
