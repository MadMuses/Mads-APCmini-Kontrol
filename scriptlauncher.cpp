#include "scriptlauncher.h"

ScriptLauncher::ScriptLauncher(QObject *parent) :
    QObject(parent),
    send_process(new QProcess(this)),
    clear_process(new QProcess(this)),
    load_process(new QProcess(this))
{
}

void ScriptLauncher::sendMidiScript()
{
    QString script = "sendmidi.bat";

    // Poser le cmd.exe
    QString command = "cmd.exe";

    // Poser les arguments de la commande
    QStringList arguments;
    arguments << "/C" << script;  // "/C" exécute le script et ferme cmd après

    // Lancer la commande
    send_process -> setWorkingDirectory((workDir+"//Mads_APCKontrol//midi//"));
    send_process -> start(command, arguments);
}

void ScriptLauncher::clearAllScript()
{
    QString script = "clearall.bat";

    // Poser le cmd.exe
    QString command = "cmd.exe";

    // Poser les arguments de la commande
    QStringList arguments;
    arguments << "/C" << script;  // "/C" exécute le script et ferme cmd après

    // Lancer la commande
    clear_process -> setWorkingDirectory((workDir+"//Mads_APCKontrol//midi//"));
    clear_process -> start(command, arguments);
}

void ScriptLauncher::loadLatestScript()
{
    QString script = "loadlatest.bat";

    // Poser le cmd.exe
    QString command = "cmd.exe";

    // Poser les arguments de la commande
    QStringList arguments;
    arguments << "/C" << script;  // "/C" exécute le script et ferme cmd après

    // Lancer la commande
    load_process -> setWorkingDirectory((workDir+"//Mads_APCKontrol//midi//"));
    load_process -> start(command, arguments);
}
