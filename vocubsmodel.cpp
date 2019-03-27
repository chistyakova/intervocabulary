#include "vocubsmodel.h"

QVariantMap VocubsModel::get(int index) {
    QVariantMap map;
    if (index >= 0 && index < vocubs_->count()) {
        map.insert("flag", vocubs_->at(index).flag);
        map.insert("title", vocubs_->at(index).title);
        map.insert("description", vocubs_->at(index).description);
    }
    return map;
}

VocubsModel::VocubsModel(QVector<Vocub> *vocubs, QObject *parent):
    QAbstractListModel(parent)
{
    vocubs_ = vocubs;
}

int VocubsModel::rowCount(const QModelIndex &parent) const {
    if (parent.isValid()) {
        return 0;
    }
    return vocubs_->count();
}

QHash<int, QByteArray> VocubsModel::roleNames() const {
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[flag] = "flag";
    roles[title] = "title";
    roles[description] = "description";
    return roles;
}

QVariant VocubsModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid()) {
        return QVariant();
    }
    switch (role) {
        case flag: {
            return vocubs_->at(index.row()).flag;
        }
        case title: {
            return vocubs_->at(index.row()).title;
        }
        case description: {
            return vocubs_->at(index.row()).description;
        }
        default:
            return QVariant();
    }
}

void VocubsModel::notifyChange() {
    beginResetModel();
    endResetModel();
}
