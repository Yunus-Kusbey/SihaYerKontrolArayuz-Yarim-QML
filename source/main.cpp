#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "command_mission.h"

int main(int argc, char* argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    qmlRegisterType<CommandMission>("GCS", 1, 0, "Command_Mission");

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
