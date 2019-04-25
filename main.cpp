#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "controller.h"

int main(int argc, char *argv[])
{
  QGuiApplication::setApplicationName("Vocub");
  QGuiApplication::setOrganizationName("Watrushsk");
  QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  QGuiApplication app(argc, argv);
  Controller *controller = new Controller();

  QQmlApplicationEngine engine;
  engine.rootContext()->setContextProperty("controller", controller);
  engine.rootContext()->setContextProperty("wordsModel", controller->words_model);
  engine.rootContext()->setContextProperty("vocubsModel", controller->vocubs_model);
  engine.load(QUrl("qrc:/main.qml"));

  return app.exec();
}
