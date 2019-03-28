#include <QDateTime>
#include <QDebug>
#include <QDir>
#include <QRandomGenerator>
#include "controller.h"
#include <math.h>

Controller::Controller(QObject *parent) : QObject(parent) {
    // Инициализируем базу данных.
    db_ = QSqlDatabase::addDatabase("QSQLITE");

    QAndroidJniObject mediaDir = QAndroidJniObject::callStaticObjectMethod("android/os/Environment", "getExternalStorageDirectory", "()Ljava/io/File;");
    QAndroidJniObject mediaPath = mediaDir.callObjectMethod( "getAbsolutePath", "()Ljava/lang/String;" );
    QString storage_path = mediaPath.toString()+"/Vocub";

    if (!QDir(storage_path).exists()) {
        QDir().mkpath(storage_path);
    }

    db_.setDatabaseName(storage_path+"/db.sqlite");
    if (!db_.open()) {
        qDebug() << db_.lastError().text();
    }

    words_model = new WordsModel(&current_words_);

    QSqlQuery q;

    if (!q.exec("CREATE TABLE IF NOT EXISTS settings ("
                "flag, "
                "title, "
                "description"
                ");")) {
        qDebug() << q.lastError();
    }
    vocubs_model = new VocubsModel(&current_vocubs_);
    getVocubs();
}

void Controller::getWords(QString vocub_title) {
    current_words_.clear();
    QSqlQuery q;
    q.exec("SELECT native_word, foreign_word FROM \""+vocub_title+"\"");
    while(q.next()) {
        Word w;
        w.native_word_ = q.value(0).toString();
        w.foreign_word_ = q.value(1).toString();
        current_words_.push_back(w);
    }
    words_model->notifyChange();
}

void Controller::getVocubs() {
    current_vocubs_.clear();
    QSqlQuery q;
    q.exec("SELECT flag, title, description FROM settings");
    while(q.next()) {
        Vocub v;
        v.flag = q.value(0).toBool();
        v.title = q.value(1).toString();
        v.description = q.value(2).toString();
        v.table_name = q.value(3).toString();
        current_vocubs_.push_back(v);
    }
    vocubs_model->notifyChange();
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
    if (!q.exec("INSERT INTO settings (flag, title, description) "
                "VALUES ('"+flag+"','"+title+"','"+description+"');")) {
        qDebug() << q.lastError();
    }
    getVocubs();
    if (!q.exec("CREATE TABLE IF NOT EXISTS '"+table_name+"'("
                "native_word text, "
                "foreign_word text"
                ");")) {
        qDebug() << q.lastError();
    }
}

void Controller::saveWord(QString vocabulary_title, QString native_word, QString foreign_word) {
    QSqlQuery q;
    if (!q.exec("CREATE TABLE IF NOT EXISTS \""+vocabulary_title+"\" ("
                "native_word text, "
                "foreign_word text"
                ");")) {
        qDebug() << q.lastError();
    }
    if (!q.exec("INSERT INTO '"+vocabulary_title+"' (native_word, foreign_word) "
                "VALUES ('"+native_word+"','"+foreign_word+"');")) {
        qDebug() << q.lastError();
    }
    Word w;
    w.native_word_ = native_word;
    w.foreign_word_ = foreign_word;
    current_words_.push_back(w);
    words_model->notifyChange();
}
