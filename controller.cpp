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

void Controller::saveVocabulary(QString flag, QString title, QString describtion) {
    qDebug() << "C++ saveVocabulary" << flag << title << describtion;
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
