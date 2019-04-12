#include "wordsmodel.h"

QVariantMap WordsModel::get(int index) {
    QVariantMap map;
    if (index >= 0 && index < words_->count()) {
        map.insert("native_word", words_->at(index).second.native_word_);
        map.insert("foreign_word", words_->at(index).second.foreign_word_);
    }
    return map;
}

WordsModel::WordsModel(QVector<QPair <int, Word>> *words, QObject *parent):
  QAbstractListModel(parent) {
  words_ = words;
}

int WordsModel::rowCount(const QModelIndex &parent) const {
    if (parent.isValid()) {
        return 0;
    }
    return words_->count();
}

QHash<int, QByteArray> WordsModel::roleNames() const {
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[native_word] = "native_word";
    roles[foreign_word] = "foreign_word";
    return roles;
}

QVariant WordsModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid()) {
        return QVariant();
    }
    switch (role) {
        case native_word: {
            return words_->at(index.row()).second.native_word_;
        }
        case foreign_word: {
            return words_->at(index.row()).second.foreign_word_;
        }
        default:
            return QVariant();
    }
}

void WordsModel::notifyChange() {
    beginResetModel();
    endResetModel();
}
