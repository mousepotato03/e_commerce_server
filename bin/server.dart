import 'dart:convert';
import 'dart:math';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_swagger_ui/shelf_swagger_ui.dart';

import 'dto/product_info.dto.dart';
import 'dto/view_module.dto.dart';

part 'data.dart';

part 'request.dart';

final handler = Router()
  ..get('/api/menus/<mallType>', menuHandler)
  ..get('/api/view-modules/<tabId>/<page>', viewModuleHandler);

void main(List<String> args) async {
  final swaggerHandler = SwaggerUI('specs/swagger.yaml');

  final cascade = Cascade()
      .add(handler)
      .add(swaggerHandler);

  final server = await serve(cascade.handler, '127.0.0.1', 8080);
}
