# Student Management System

A Flutter mobile application for managing student records with Firebase Firestore.

## Features

- Create a student with `name`, `studentId`, `email`, `course`, and `age`
- Read all students from Firestore in real time
- Update existing student records
- Delete student records with confirmation

## Project structure

- `lib/main.dart`: app entry point
- `lib/firebase_options.dart`: placeholder Firebase config, replace with your own
- `lib/models/student.dart`: student data model
- `lib/services/student_service.dart`: Firestore CRUD service
- `lib/pages/home_page.dart`: tab-based navigation
- `lib/pages/create_student_page.dart`: create form
- `lib/pages/student_list_page.dart`: read dashboard
- `lib/pages/delete_student_page.dart`: delete by student ID
- `lib/pages/edit_student_page.dart`: update form

## Setup

### 1. Install Flutter

Install Flutter SDK, then verify:

```powershell
flutter doctor
```

### 2. Generate native folders

This workspace was prepared without the Flutter SDK, so generate the platform folders locally:

```powershell
flutter create .
```

If Flutter asks to overwrite files, keep the existing `lib/`, `pubspec.yaml`, and `README.md` versions from this project.

### 3. Install packages

```powershell
flutter pub get
```

### 4. Create a Firebase project

In Firebase Console:

1. Create a new project
2. Add an Android app
3. Use an Android package name such as `com.example.student_management_system`
4. Download `google-services.json`
5. Place it in `android/app/google-services.json`
6. Enable `Cloud Firestore`

### 5. Configure Firebase for Flutter

Recommended:

```powershell
dart pub global activate flutterfire_cli
flutterfire configure
```

That command will regenerate `lib/firebase_options.dart` with your real Firebase values.

If you do not use `flutterfire configure`, manually replace the placeholder values in `lib/firebase_options.dart`.

### 6. Update Android Firebase build files

After `flutter create .`, confirm these files include Firebase setup.

`android/build.gradle`:

```gradle
dependencies {
    classpath 'com.google.gms:google-services:4.4.2'
}
```

`android/app/build.gradle`:

```gradle
plugins {
    id "com.google.gms.google-services"
}
```

### 7. Firestore rules for development

Use temporary development rules while testing:

```text
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```

Do not keep these open rules for production.

## Run

```powershell
flutter run
```

## Firestore collection

Collection name: `students`

Document fields:

- `name`: string
- `studentId`: string
- `email`: string
- `course`: string
- `age`: number
- `createdAt`: timestamp



