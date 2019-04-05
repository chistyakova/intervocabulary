#include <QDateTime>
#include <QDebug>
#include <QDir>
#include <QRandomGenerator>
#include "controller.h"
#include <math.h>

Controller::Controller(QObject *parent) : QObject(parent) {
    // Инициализируем базу данных.
    db_ = QSqlDatabase::addDatabase("QSQLITE");

    QString storage_path;
#ifdef __ANDROID__
    QAndroidJniObject mediaDir = QAndroidJniObject::callStaticObjectMethod("android/os/Environment", "getExternalStorageDirectory", "()Ljava/io/File;");
    QAndroidJniObject mediaPath = mediaDir.callObjectMethod( "getAbsolutePath", "()Ljava/lang/String;" );
    storage_path = mediaPath.toString()+"/Vocub";
#else
    storage_path = ".";
#endif

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
    current_words_.clear();
    for(auto vocub : current_vocubs_)
    {
        if(vocub.flag)
        {
            getWords(vocub.title);
        }
    }
}

void Controller::getWords(QString vocub_title) {
    current_words_.clear(); // очищаем вектор со словами из предыдущего словаря
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

void Controller::getWords() {
    current_words_.clear();
    QSqlQuery q;
    q.exec("SELECT flag, title FROM settings");
    QStringList selected_vocubs_titles;
    while(q.next()) {
        bool is_vocub_selected = q.value(0).toBool();
        if (is_vocub_selected) {
            QString vocub_title = q.value(1).toString();
            selected_vocubs_titles.append(vocub_title);
        }
    }
    for (const auto& vocub_title : selected_vocubs_titles) {
        q.exec("SELECT native_word, foreign_word FROM \""+vocub_title+"\"");
        while(q.next()) {
            Word w;
            w.native_word_ = q.value(0).toString();
            w.foreign_word_ = q.value(1).toString();
            current_words_.push_back(w);
        }
    }
    q.exec();
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
        current_vocubs_.push_back(v);
    }
    vocubs_model->notifyChange();
}

QVariantMap Controller::getNextWord() {
    QVariantMap map;
    if (!current_words_.length()){
        // отправляем в qml пустой объект, если слов нет
        return map;
    }
    QRandomGenerator generator;
    int random = QRandomGenerator::global()->bounded(current_words_.length());
    qDebug() << "Total:" << current_words_.length() << " Random:" << random;
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

void Controller::setVocubFlag(QString vocabulary_title, int flag) {
    QSqlQuery q;
    if (!q.exec("UPDATE settings SET flag='"+QString::number(flag)+"' WHERE title='"+vocabulary_title+"';")) {
        qDebug() << q.lastError();
    }
    qDebug() << "UPDATE settings SET flag='"+QString::number(flag)+"' WHERE title='"+vocabulary_title+"';";
    for(auto vocub : current_vocubs_)
    {
        if(vocub.title == vocabulary_title) {
            vocub.flag = flag;
            vocubs_model->notifyChange();
            break;
        }
    }
}
