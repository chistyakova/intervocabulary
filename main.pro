TARGET = vocub

QT += qml quick svg sql

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
