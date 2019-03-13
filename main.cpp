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
    ctxt->setContextProperty("groupsModel", controller->groupsModel);
    ctxt->setContextProperty("tableModel", controller->tableModel);
    ctxt->setContextProperty("iconsModel", controller->iconsModel);

    view.setSource(QUrl("qrc:/main.qml"));
    view.show();

	return app.exec();
}
