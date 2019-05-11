#include <QDateTime>
#include <QDebug>
#include <QDir>
#include <QRandomGenerator>
#include "controller.h"
#include <math.h>
#include <algorithm>    // std::random_shuffle

Controller::Controller(QObject *parent) : QObject(parent), next_word_index_(0) {
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
    q.exec("SELECT native_word, foreign_word, is_learned, counter FROM \""+vocub_title+"\"");
    int i=0;
    while(q.next()) {
        Word w;
        w.native_word_  = q.value(0).toString();
        w.foreign_word_ = q.value(1).toString();
        w.is_learned    = q.value(2).toBool();
        w.counter       = q.value(3).toInt();
        current_words_.push_back(QPair<int, Word>(i++, w));
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
    qDebug() << selected_vocubs_titles;
    for (const auto& vocub_title : selected_vocubs_titles) {
        q.exec("SELECT native_word, foreign_word, is_learned, counter FROM \""+vocub_title+"\"");
        int i=0;
        while(q.next()) {
            Word w;
            w.native_word_  = q.value(0).toString();
            w.foreign_word_ = q.value(1).toString();
            w.is_learned    = q.value(2).toBool();
            w.counter       = q.value(3).toInt();
            current_words_.push_back(QPair<int, Word>(i++, w));
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

void Controller::shuffleWords(bool shuffle)
{
    if(shuffle) std::random_shuffle(current_words_.begin(), current_words_.end());
    else qSort(current_words_.begin(), current_words_.end(), QPairFirstComparer());
    next_word_index_ = 0;
}

QVariantMap Controller::getNextWord() {
    QVariantMap map;
    if (!current_words_.length()){
        // отправляем в qml пустой объект, если слов нет
        return map;
    }

    if(next_word_index_ >= current_words_.size()) next_word_index_ = 0;
    qDebug() << next_word_index_;
    map.insert("native_word", current_words_.at(next_word_index_).second.native_word_);
    map.insert("foreign_word", current_words_.at(next_word_index_).second.foreign_word_);
    map.insert("is_learned", current_words_.at(next_word_index_).second.is_learned);
    map.insert("counter", current_words_.at(next_word_index_).second.counter);
    next_word_index_++;
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
                "foreign_word text, "
                "is_learned INTEGER,"
                "counter INTEGER"
                ");")) {
        qDebug() << q.lastError();
    }
}

void Controller::saveWord(QString vocabulary_title, QString native_word, QString foreign_word) {
    QSqlQuery q;
    if (!q.exec("CREATE TABLE IF NOT EXISTS \""+vocabulary_title+"\" ("
                "native_word text, "
                "foreign_word text, "
                "is_learned INTEGER,"
                "counter INTEGER"
                ");")) {
        qDebug() << q.lastError();
    }
    if (!q.exec("INSERT INTO '"+vocabulary_title+"' (native_word, foreign_word, is_learned, counter) "
                "VALUES ('"+native_word+"','"+foreign_word+"', 0, 0);")) {
        qDebug() << q.lastError();
    }
    Word w;
    w.native_word_ = native_word;
    w.foreign_word_ = foreign_word;
    current_words_.push_back(QPair<int, Word>(current_words_.size(),w));
    words_model->notifyChange();
}

void Controller::removeWord(QString vocabulary_title, QString foreign_word) {
    for(int i = 0; i < current_words_.size(); ++i) {
        Word *word = &current_words_[i].second;
        if(word->foreign_word_ == foreign_word) {
            current_words_.remove(i);
            QSqlQuery q;
            if (!q.exec("DELETE FROM '"+vocabulary_title+"' WHERE foreign_word='"+foreign_word+"';")) {
                qDebug() << q.lastError();
            }
            words_model->notifyChange();
            break;
        }
    }
}

void Controller::toggleVocubFlag(QString vocabulary_title) {
    for(int i = 0; i < current_vocubs_.size(); ++i) {
        Vocub *vocub = &current_vocubs_[i];
        if(vocub->title == vocabulary_title) {
            bool flag = vocub->flag = !(vocub->flag);
            QSqlQuery q;
            if (!q.exec("UPDATE settings SET flag="+QString::number(flag)+" WHERE title='"+vocabulary_title+"';")) {
                qDebug() << q.lastError();
            }
            vocubs_model->notifyChange();
            break;
        }
    }
}
