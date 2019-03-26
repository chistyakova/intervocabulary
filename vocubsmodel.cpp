#include "vocubsmodel.h"

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
    roles[table_name] = "table_name";
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
        case table_name: {
            return vocubs_->at(index.row()).table_name;
        }
        default:
            return QVariant();
    }
}
