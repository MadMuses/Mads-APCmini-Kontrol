#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>
#include <QFile>
#include <QTextStream>
#include <QDebug>

class FileIO : public QObject
{
    Q_OBJECT

public slots:
    Q_INVOKABLE bool write(const QString& source, const QString& data);
    Q_INVOKABLE QString read(const QString& source);

public:
    FileIO();
};

#endif // FILEIO_H
