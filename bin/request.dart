part of 'server.dart';

// CORS 설정
const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, DELETE, OPTIONS',
  'Access-Control-Allow-Headers': 'Origin, Content-Type',
};

// OPTIONS 요청에 대한 핸들러 추가
Response handleOptions(Request request) {
  return Response.ok(null, headers: corsHeaders);
}

var menuHandler = (Request request, String mallType) {
  List<Map<String, Object>> data;

  if (mallType == 'market') {
    data = marketStore;
  } else {
    data = beautyStore;
  }

  Map<String, dynamic> result = {
    'status': 'SUCCESS',
    'code': '0000',
    'message': '성공',
    'data': data,
  };

  return Response(
    200,
    body: jsonEncode(result),
    headers: {
      'Content-type': 'application/json',
      ...corsHeaders,
    },
  );
};

var viewModuleHandler = (Request request, String tabId, String page) {
  Map<String, dynamic> result = {
    'status': 'SUCCESS',
    'code': '0000',
    'message': '성공',
  };

  if (int.parse(page) >= 5) {
    result['data'] = [];
  } else {
    result['data'] = viewModules(
      tabId.startsWith('1', 0) ? 'market' : 'beauty',
    );
  }

  return Response(
    200,
    body: jsonEncode(result),
    headers: {
      'Content-type': 'application/json',
      ...corsHeaders,
    },
  );
};
