#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QHash>
#include <QVector>
#include <QtSql>

class Controller : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int tileSize READ getTileSize NOTIFY tileSizeChanged)
public:
    explicit Controller(QObject *parent = nullptr);
    Q_INVOKABLE QString getNextWord();
    int getTileSize();
private:
    int tile_size_;
signals:
    void tileSizeChanged();
public slots:    
};

#endif // CONTROLLER_H
