#include "api.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QScreen>

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QMap<QString, QObject *> integrations{{"api", new Api(&app)}};
    for (auto integration = integrations.constKeyValueBegin();
         integration != integrations.constKeyValueEnd(); ++integration) {
        engine.rootContext()->setContextProperty(integration->first,
                                                 integration->second);
    }
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
        []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);
    engine.load(QUrl("qrc:/qml/Main.qml"));
    return app.exec();
}
