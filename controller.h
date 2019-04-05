#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QVariant>
#include <QtSql>
#ifdef __ANDROID__
#include <QAndroidJniObject>
#endif

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

    // Эту функцию вызываем по нажатию на кнопку редактирования словаря,
    // и она загружает в current_words_ слова, соответствующие title словаря.
    Q_INVOKABLE void getWords(QString vocub_title);

    // Заполняем current_words_ словами из всех выбранных словарей.
    // Вызывается в main.qml перед открытием кадра тренировки.
    Q_INVOKABLE void getWords();

    // Инвертируем признак используемости словаря.
    Q_INVOKABLE void toggleVocubFlag(QString vocabulary_title);

    int getTileSize();
    WordsModel *words_model;
    VocubsModel *vocubs_model;
private:
    QVector<Word> current_words_;
    QVector<Vocub> current_vocubs_;
    QSqlDatabase db_;
    int tile_size_;

    void getVocubs();

signals:
    void tileSizeChanged();
public slots:
};

#endif // CONTROLLER_H
