// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _GetDataService implements GetDataService {
  _GetDataService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }
  final Dio _dio;
  String baseUrl;


  Future<List<FeedsResponse>> getFeeds( page, limit) async {
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'page_limit': limit
    };
    const _extra = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _result = await _dio.fetch(
        _setStreamType<FeedsResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'interview/feed',
                queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    // debugger();
 //    feedsResponseFromJson(_result.data);
     final value = List<FeedsResponse>.from(_result.data.map((e)=> FeedsResponse.fromJson(e))).toList();
        //_result.data.map((e)
 //
   // final value = FeedsResponse.fromJson(_result.data);

   // FeedsResponse.fromJson(_result.data);
    return value;
  }


  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
