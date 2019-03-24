#include <QDateTime>
#include <QDebug>
#include "controller.h"
#include <math.h>

Controller::Controller(QObject *parent) : QObject(parent) {
    // Инициализируем базу данных.
    db_ = QSqlDatabase::addDatabase("QSQLITE");
    db_.setDatabaseName("intervocabulary.sqlite");
    if (!db_.open())
        qDebug() << db_.lastError().text();
    QSqlQuery query("CREATE TABLE IF NOT EXISTS default "
                    "(native TEXT, translation TEXT);");
    query.exec("SELECT native,translation FROM default");
    while(query.next()) {
      Word w;
      w.native_ = query.value(0).toString();
      w.translation_ = query.value(1).toString();
      current_words_.push_back(w);
    }
    dictionary_model = new DictionaryModel(&current_words_);
}


QVariantMap Controller::getNextWord() {
    Word w;
    w.native_ = QDateTime::currentDateTime().toString();
    QVariantMap map;
    map.insert("native_word", w.native_);
    map.insert("foreign_word", w.translation_);
    map.insert("transcribtion", w.transcribtion_);
    return map;
}

void Controller::addNewWord(QString native, QString translation) {
    // В эту функцию приходят добавленные из QML слово и перевод.
    // Записываем их в дефолтную таблицу базы данных.
    QSqlQuery q;
    q.exec("INSERT INTO default (native, translation) VALUES "
           "(\""+native+"\",\""+translation+"\");");
}

int Controller::getTileSize() {
    return tile_size_;
}

void Controller::saveVocabulary(QString flag, QString title, QString describtion) {
    qDebug() << "C++ saveVocabulary" << flag << title << describtion;
}

void Controller::saveWord(QString vocabulary_title, QString native_word, QString foreign_word) {
    qDebug() << "C++ saveWord" << vocabulary_title << native_word << foreign_word;
}
