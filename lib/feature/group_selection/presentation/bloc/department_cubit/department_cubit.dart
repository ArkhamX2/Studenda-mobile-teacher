import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:studenda_mobile_student/feature/group_selection/domain/entities/department_entity.dart';
import 'package:studenda_mobile_student/feature/group_selection/domain/usecases/load_departments.dart';

part 'department_state.dart';
part 'department_cubit.freezed.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  final LoadDepartments loadDepartments;

  List<DepartmentEntity> departmentList = [];

  DepartmentCubit({required this.loadDepartments})
      : super(const DepartmentState.initial());
  Future<void> load() async {
    final departments = await loadDepartments(() {});
    departments.fold(
      (l) => emit(DepartmentState.fail(l.message)),
      (r) {
        departmentList = r
            .map(
              (element) => DepartmentEntity(
                id: element.id,
                name: element.name,
              ),
            )
            .toList();
        emit(
          DepartmentState.success(
            departmentList,
          ),
        );
      },
    );
  }

  Future<void> loadLocally() async {
    emit(const DepartmentState.loading());
    final departments = await loadDepartments(() {});
    departments.fold(
      (l) => emit(DepartmentState.fail(l.message)),
      (r) {
        departmentList = r
            .map(
              (element) => DepartmentEntity(
                id: element.id,
                name: element.name,
              ),
            )
            .toList();
        emit(
          DepartmentState.success(
            departmentList,
          ),
        );
      },
    );
  }
}
