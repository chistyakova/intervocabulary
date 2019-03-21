#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QVariant>
#include <QtSql>

#include "dictionarymodel.h"
#include "word.h"

class Controller : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int tileSize READ getTileSize NOTIFY tileSizeChanged)
public:
    explicit Controller(QObject *parent = nullptr);
    Q_INVOKABLE QVariantMap getNextWord();
    Q_INVOKABLE void addNewWord(QString, QString);
    int getTileSize();
    DictionaryModel *dictionary_model;
private:
    QVector<Word> current_words_;
    QSqlDatabase db_;
    int tile_size_;
signals:
    void tileSizeChanged();
public slots:    
};

#endif // CONTROLLER_H
