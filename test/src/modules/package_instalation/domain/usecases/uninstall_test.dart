import 'package:either_dart/either.dart';
import 'package:mocktail/mocktail.dart';
import 'package:slidy/src/core/entities/slidy_process.dart';
import 'package:slidy/src/core/errors/errors.dart';
import 'package:slidy/src/modules/package_instalation/domain/errors/errors.dart';
import 'package:slidy/src/modules/package_instalation/domain/models/package_name.dart';
import 'package:slidy/src/modules/package_instalation/domain/repositories/package_instalation_repository.dart';
import 'package:slidy/src/modules/package_instalation/domain/usecases/uninstall.dart';
import 'package:test/test.dart';

class PackageInstalationRepositoryMock extends Mock implements PackageInstalationRepository {}

void main() {
  final service = PackageInstalationRepositoryMock();

  final usecase = Uninstall(service);

  test('should install package', () async {
    final mockParam = PackageName('package');
    when(() => service.uninstall(mockParam)).thenAnswer((_) async => Right<SlidyError, SlidyProccess>(SlidyProccess(result: 'ok')));
    final result = await usecase(params: mockParam);
    expect(result.right, isA<SlidyProccess>());
  });

  test('install package error', () async {
    final mockParam = PackageName('package');
    when(() => service.uninstall(mockParam)).thenAnswer((_) async => Left<SlidyError, SlidyProccess>(PackageInstalationError('Error')));
    final result = await usecase(params: mockParam);
    expect(result.left, isA<PackageInstalationError>());
  });
}