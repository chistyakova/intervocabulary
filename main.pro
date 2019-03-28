TARGET = vocub

QT += qml quick svg sql androidextras

CONFIG += c++11

SOURCES += \
    main.cpp \
    controller.cpp \
    word.cpp \
    wordsmodel.cpp \
    vocubsmodel.cpp \
    vocub.cpp

HEADERS += \
    controller.h \
    helpers.h \
    word.h \
    wordsmodel.h \
    vocubsmodel.h \
    vocub.h

RESOURCES += \
    resources.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH = $$PWD

DESTDIR = $$PWD

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android
}
