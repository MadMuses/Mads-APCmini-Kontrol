#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QProcess>
#include <QCoreApplication>
#include <QQmlContext>

#include "fileio.h"
#include "scriptlauncher.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    qmlRegisterType<FileIO>("fileIO", 1, 0, "FileIO");
    qmlRegisterType<ScriptLauncher>("scriptLauncher", 1, 0, "ScriptLauncher");

    ScriptLauncher scriptlauncher;
    scriptlauncher.loadLatestScript();

    engine.rootContext()->setContextProperty("workDir", QCoreApplication::applicationDirPath());
    engine.loadFromModule("Mads_APCKontrol", "Main");

    return app.exec();
}
