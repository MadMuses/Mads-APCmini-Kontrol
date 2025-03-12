#ifndef SCRIPTLAUNCHER_H
#define SCRIPTLAUNCHER_H

#include <QObject>
#include <QProcess>
#include <QDebug>
#include <QCoreApplication>

class ScriptLauncher : public QObject
{

    Q_OBJECT

public:
    explicit ScriptLauncher(QObject *parent = 0);
    Q_INVOKABLE void sendMidiScript();
    Q_INVOKABLE void clearAllScript();
    Q_INVOKABLE void loadLatestScript();

private:
    QProcess *send_process;
    QProcess *clear_process;
    QProcess *load_process;
    QString workDir = QCoreApplication::applicationDirPath();
};

#endif
