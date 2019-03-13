QT += qml quick sql

CONFIG += c++11

SOURCES += \
    main.cpp \
    tablemodel.cpp \
    groupsmodel.cpp \
    controller.cpp \
    rawtable.cpp \
    rawitem.cpp

HEADERS += \
    tablemodel.h \
    groupsmodel.h \
    controller.h \
    rawtable.h \
    rawgroup.h \
    rawitem.h \
    helpers.h

RESOURCES += \
    resources.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH = $$PWD

DESTDIR = $$PWD
