#include "fileio.h"

FileIO::FileIO() {}

bool FileIO::write(const QString& source, const QString& data){
    if (source.isEmpty())
        return false;

    QFile file(source);
    if (!file.open(QFile::WriteOnly | QFile::Truncate)) {
        qDebug() << "Erreur lors de l'ouverture du fichier:" << file.errorString();
        return false;
    }

    QTextStream out(&file);
    out << data;
    file.close();

    return true;
}

QString FileIO::read(const QString& source) {
    if (source.isEmpty()) {
        qDebug() << "Chemin du fichier vide";
        return QString();
    }

    QFile file(source);
    if (!file.open(QFile::ReadOnly | QFile::Text)) {
        qDebug() << "Erreur lors de l'ouverture du fichier:" << file.errorString();
        return QString();
    }

    QTextStream in(&file);
    QString data = in.readAll();
    file.close();

    return data;
}
