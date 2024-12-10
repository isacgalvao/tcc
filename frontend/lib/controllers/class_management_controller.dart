import 'package:flutter/material.dart';
import 'package:frontend/clients/attendance_client.dart';
import 'package:frontend/clients/class_client.dart';
import 'package:frontend/clients/exam_client.dart';
import 'package:frontend/clients/note_client.dart';
import 'package:frontend/models/attendance.dart';
import 'package:frontend/models/class.dart';
import 'package:frontend/models/exam.dart';
import 'package:frontend/models/note.dart';
import 'package:frontend/widgets/snackbar.dart';
import 'package:get/get.dart';

class ClassManagementController extends GetxController {
  static const initialPage = 0;

  final _selectedIndex = initialPage.obs;
  final pageController = PageController(initialPage: 0);

  get selectedIndex => _selectedIndex.value;

  // entities
  final Class _class;

  get className => _class.name;
  get classCreatedAt => _class.createdAt;

  // client
  final client = Get.put(ClassClient());

  // observables
  final _isLoading = false.obs;
  final _switchController = ValueNotifier(false);

  get isLoading => _isLoading.value;
  get switchController => _switchController;

  ClassManagementController(this._class);

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onItemTapped(int index) {
    _selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  void onChanged(dynamic value) async {
    try {
      _isLoading(true);
      final bool result = value
          ? await client.enableNotifications(_class.id)
          : await client.disableNotifications(_class.id);
      if (!result) {
        _switchController.value = !value;
        failSnackbar('Erro', 'Não foi possível alterar as notificações');
      }
    } catch (e) {
      _switchController.value = !value;
      failSnackbar('Erro', 'Não foi possível alterar as notificações');
    } finally {
      _isLoading(false);
    }
  }
}

class AttendanceController extends GetxController {
  final _attendances = <Attendance>[].obs;
  final _isLoading = false.obs;

  List<Attendance> get attendances => _attendances;
  bool get isLoading => _isLoading.value;

  final client = Get.put(AttendanceClient());

  @override
  void onInit() {
    fetchAttendance();
    super.onInit();
  }

  void fetchAttendance() async {
    try {
      _isLoading(true);
      _attendances.assignAll(await client.fetchAttendance());
    } finally {
      _isLoading(false);
    }
  }
}

class NotesController extends GetxController {
  final _notes = <Note>[].obs;
  final _isLoading = false.obs;

  List<Note> get notes => _notes;
  bool get isLoading => _isLoading.value;

  final client = Get.put(NoteClient());

  @override
  void onInit() {
    fetchNotes();
    super.onInit();
  }

  void fetchNotes() async {
    try {
      _isLoading(true);
      _notes.assignAll(await client.fetchNotes());
    } finally {
      _isLoading(false);
    }
  }

  void addNote(String note) async {
    try {
      _isLoading(true);
      await Future.delayed(const Duration(seconds: 2));
      // final Note note = await client.addNote();
      // if (note != null) {
      //   _notes.add(note);
      // }
    } finally {
      _isLoading(false);
    }
  }
}

class ExamsController extends GetxController {
  final _exams = <Exam>[].obs;
  final _isLoading = false.obs;
  final _isConsolidating = false.obs;

  List<Exam> get exams => _exams;
  bool get isLoading => _isLoading.value;
  bool get isConsolidating => _isConsolidating.value;

  final client = Get.put(ExamClient());

  @override
  void onInit() {
    fetchExams();
    super.onInit();
  }

  void fetchExams() async {
    try {
      _isLoading(true);
      _exams.assignAll(await client.fetchExams());
    } finally {
      _isLoading(false);
    }
  }

  Future<void> consolidateGrades() async {
    try {
      _isConsolidating(true);
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      _isConsolidating(false);
    }
  }
}
