#include <QDateTime>
#include <QDebug>
#include <QRandomGenerator>
#include "controller.h"
#include <math.h>

Controller::Controller(QObject *parent) : QObject(parent) {
    // Инициализируем базу данных.
    db_ = QSqlDatabase::addDatabase("QSQLITE");
    db_.setDatabaseName("db.sqlite");
    if (!db_.open()) {
        qDebug() << db_.lastError().text();
    }
    QSqlQuery q;
    if (!q.exec("CREATE TABLE IF NOT EXISTS default_table ("
                "native_word text, "
                "foreign_word text"
                ");")) {
        qDebug() << q.lastError();
    }
    getWords();
    words_model = new WordsModel(&current_words_);

    if (!q.exec("CREATE TABLE IF NOT EXISTS settings ("
                "flag, "
                "title, "
                "description, "
                "table_name"
                ");")) {
        qDebug() << q.lastError();
    }
    getVocubs();
    vocubs_model = new VocubsModel(&current_vocubs_);
}

void Controller::getWords() {
    current_words_.clear();
    QSqlQuery q;
    q.exec("SELECT native_word, foreign_word FROM default_table");
    while(q.next()) {
      Word w;
      w.native_word_ = q.value(0).toString();
      w.foreign_word_ = q.value(1).toString();
      current_words_.push_back(w);
    }
}

void Controller::getVocubs() {
    current_vocubs_.clear();
    QSqlQuery q;
    q.exec("SELECT flag, title, description, table_name FROM settings");
    while(q.next()) {
      Vocub v;
      v.flag = q.value(0).toBool();
      v.title = q.value(1).toString();
      v.description = q.value(2).toString();
      v.table_name = q.value(3).toString();
      current_vocubs_.push_back(v);
    }
}

QVariantMap Controller::getNextWord() {
    QRandomGenerator generator;
    int random = QRandomGenerator::global()->bounded(current_words_.length());
    qDebug() << "Total:" << current_words_.length() << " Random:" << random;
    QVariantMap map;
    map.insert("native_word", current_words_.at(random).native_word_);
    map.insert("foreign_word", current_words_.at(random).foreign_word_);
    return map;
}

int Controller::getTileSize() {
    return tile_size_;
}

void Controller::saveVocab(QString flag, QString title, QString description) {
    qDebug() << "C++ saveVocabulary" << flag << title << description;
    QString table_name = title;//проверка что нет такого имени
    QSqlQuery q;
    if (!q.exec("INSERT INTO settings (flag, title, description, table_name) "
                "VALUES ('"+flag+"','"+title+"','"+description+"','"+table_name+"');")) {
        qDebug() << q.lastError();
    }
    getVocubs();
}

void Controller::saveWord(QString vocabulary_title, QString native_word, QString foreign_word) {
    qDebug() << "C++ saveWord" << vocabulary_title << native_word << foreign_word;
    QSqlQuery q;
    if (!q.exec("INSERT INTO default_table (native_word, foreign_word) "
                "VALUES ('"+native_word+"','"+foreign_word+"');")) {
        qDebug() << q.lastError();
    }
    getWords();
}
