#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QVariant>
#include <QtSql>

#include "wordsmodel.h"
#include "vocubsmodel.h"
#include "word.h"
#include "vocub.h"

class Controller : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int tileSize READ getTileSize NOTIFY tileSizeChanged)
public:
    explicit Controller(QObject *parent = nullptr);
    Q_INVOKABLE QVariantMap getNextWord();
    Q_INVOKABLE void saveVocab(QString, QString, QString);

    // В эту функцию приходят слова из qml-кадра редактирования/добавления слова.
    // Переменные:
    //   vocabulary_title - название словаря;
    //   native_word      - слово на родном языке;
    //   foreign_word     - перевод слова;
    Q_INVOKABLE void saveWord(QString vocabulary_title, QString native_word, QString foreign_word);

    int getTileSize();
    WordsModel *words_model;
    VocubsModel *vocubs_model;
private:
    QVector<Word> current_words_;
    QVector<Vocub> current_vocubs_;
    QSqlDatabase db_;
    int tile_size_;


    void getWords();
    void getVocubs();

signals:
    void tileSizeChanged();
public slots:
};

#endif // CONTROLLER_H
