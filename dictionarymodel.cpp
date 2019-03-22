#include "dictionarymodel.h"

DictionaryModel::DictionaryModel(QVector<Word> *words, QObject *parent):
  QAbstractListModel(parent) {
  words_ = words;
}

int DictionaryModel::rowCount(const QModelIndex &parent) const {
    if (parent.isValid()) {
        return 0;
    }
    return words_->count();
}

QHash<int, QByteArray> DictionaryModel::roleNames() const {
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[Native] = "native";
    roles[Translation] = "translation";
    return roles;
}

QVariant DictionaryModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid()) {
        return QVariant();
    }
    switch (role) {
        case Native: {
            return words_->at(index.row()).native_;
        }
        case Translation: {
            return words_->at(index.row()).translation_;
        }
        default:
            return QVariant();
    }
}

