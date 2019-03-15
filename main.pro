QT += qml quick sql

CONFIG += c++11

SOURCES += \
    main.cpp \
    controller.cpp \
    word.cpp

HEADERS += \
    controller.h \
    helpers.h \
    word.h

RESOURCES += \
    resources.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH = $$PWD

DESTDIR = $$PWD
