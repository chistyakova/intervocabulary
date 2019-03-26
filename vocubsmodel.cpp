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
    roles[language] = "language";
    roles[training_flag] = "training_flag";
    return roles;
}

QVariant VocubsModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid()) {
        return QVariant();
    }
    switch (role) {
        case language: {
            return vocubs_->at(index.row()).language;
        }
        case training_flag: {
            return vocubs_->at(index.row()).training_flag;
        }
        default:
            return QVariant();
    }
}
