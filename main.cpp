#include <QGuiApplication>

#include <qqmlengine.h>
#include <qqmlcontext.h>
#include <qqml.h>
#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>

#include "controller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickView view;
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    Controller *controller = new Controller();
    QQmlContext *ctxt = view.rootContext();
    ctxt->setContextProperty("controller", controller);
    ctxt->setContextProperty("wordsModel", controller->words_model);
    ctxt->setContextProperty("vocubsModel", controller->vocubs_model);

    view.setSource(QUrl("qrc:/main.qml"));
    view.show();

    return app.exec();
}
