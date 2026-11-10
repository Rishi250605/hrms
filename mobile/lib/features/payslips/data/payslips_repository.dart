import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_providers.dart';
import '../../../core/api/guard.dart';

part 'payslips_repository.g.dart';

/// A PDF picked for the bulk upload.
class PayslipFile {
  const PayslipFile({required this.name, required this.bytes});

  final String name;
  final Uint8List bytes;
}

/// Payslips (PHASE-2-FEATURES §7): PDFs uploaded by HR, viewed via short-lived signed URLs.
class PayslipsRepository {
  PayslipsRepository(this._api);

  final HrmsApi _api;

  /// Files per upload request; the API accepts up to 100 (and 10 MB each).
  static const batchSize = 25;

  PayslipsApi get _p => _api.getPayslipsApi();

  /// [scope]: mine | team | all.
  Future<PayslipPage> list({required String scope, String? period, String? businessUnitId, String? q, String? cursor}) =>
      guardApi(() async => (await _p.listPayslips(scope: scope, period: period, businessUnitId: businessUnitId, q: q, cursor: cursor)).data!);

  Future<SignedUrlResponse> download(String id, {int? version}) => guardApi(() async => (await _p.downloadPayslip(id: id, version: version)).data!);

  Future<List<PayslipVersionListItemsInner>> versions(String id) => guardApi(() async => (await _p.listPayslipVersions(id: id)).data!.items);

  /// Uploads in batches and merges the per-batch results. [onProgress] gets the number of files sent so far.
  Future<PayslipUploadResult> upload(String period, List<PayslipFile> files, {void Function(int sent)? onProgress}) => guardApi(() async {
    final matched = <PayslipUploadMatch>[];
    final replaced = <PayslipUploadMatch>[];
    final unmatched = <String>[];
    final invalid = <PayslipUploadResultInvalidInner>[];
    final duplicates = <String>[];
    // Duplicates across batches are only detectable on the device: send each employee code once.
    final seen = <String, int>{};
    for (final f in files) {
      final key = f.name.toLowerCase();
      seen[key] = (seen[key] ?? 0) + 1;
    }
    final unique = files.where((f) => seen[f.name.toLowerCase()] == 1).toList();
    duplicates.addAll(files.where((f) => seen[f.name.toLowerCase()]! > 1).map((f) => f.name));
    for (var i = 0; i < unique.length; i += batchSize) {
      final chunk = unique.sublist(i, i + batchSize > unique.length ? unique.length : i + batchSize);
      final res = (await _p.uploadPayslips(
        period: period,
        files: [for (final f in chunk) MultipartFile.fromBytes(f.bytes, filename: f.name, contentType: DioMediaType('application', 'pdf'))],
      )).data!;
      matched.addAll(res.matched);
      replaced.addAll(res.replaced);
      unmatched.addAll(res.unmatched);
      invalid.addAll(res.invalid);
      duplicates.addAll(res.duplicates);
      onProgress?.call(i + chunk.length);
    }
    return PayslipUploadResult(period: period, matched: matched, replaced: replaced, unmatched: unmatched, invalid: invalid, duplicates: duplicates);
  });
}

@Riverpod(keepAlive: true)
PayslipsRepository payslipsRepository(Ref ref) => PayslipsRepository(ref.watch(hrmsApiProvider));
