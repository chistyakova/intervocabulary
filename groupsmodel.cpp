#include <QDebug>

#include "groupsmodel.h"

GroupsModel::GroupsModel(QStringList *settings, QObject *parent):
    QAbstractListModel(parent) {
    settings_ = settings;
}

int GroupsModel::rowCount(const QModelIndex &parent) const {
    if (parent.isValid()) {
        return 0;
    }
    return settings_->count() + permanentButtons_.count();
}

QVariant GroupsModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid()) {
        return QVariant();
    }
    if (role == SplitNumberRole) {
        return 1; //pair.second;
    }

    //uint rawgroup_id = pair.first;
    //QHash<uint, RawGroup*>::iterator it = rawgroups_->find(rawgroup_id);
    //Q_ASSERT(it != rawgroups_->end());
    //RawGroup *group = it.value();
    switch (role) {
        case NameRole: {
            return "";//*group->GetName();
        }
        case DescrptionRole: {
            return "";//*group->GetName();
        }
        case ImageRole: {
            if (index.row() < settings_->count()) {
                return settings_->at(index.row());
            } else {
                return permanentButtons_.at(index.row() - settings_->count());
            }
        }
        case ClickedRole: {
            return false;//(index.row() == index_);
        }
        default:
            return QVariant();
    }
}

QHash<int, QByteArray> GroupsModel::roleNames() const {
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[NameRole] = "name";
    roles[DescrptionRole] = "description";
    roles[ImageRole] = "image";
    roles[SplitNumberRole] = "splitnumber";
    roles[ClickedRole] = "clicked";
    return roles;
}

void GroupsModel::add(const int index) {
//    beginInsertRows(QModelIndex(), m_data->size(), m_data->size());
//    m_data->append("new");
//    endInsertRows();

//    m_data[0] = QString("Size: %1").arg(m_data->size());
//    QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
//    emit dataChanged(index, index);
}

void GroupsModel::change(const int index, const QString value) {
    //QStringList row = m_data.at(index).at;
    //row.replace(0, value);
    //m_data.replace(index, row);
    //QModelIndex i = createIndex(index, row.size(), static_cast<void *>(0));
    //emit dataChanged(i, i);
}

void GroupsModel::reset() {
    emit beginResetModel();
    //pairs_rawgroup_split_number_ = pairs_rawgroup_split_number;
    //index_ = index;
    emit endResetModel();
}

void GroupsModel::clickTab(uint index) {
    index_ = index;
    emit dataChanged(createIndex(0, 0), createIndex(rowCount(), 0),
                     QVector<int>() << GroupsModel::ClickedRole);

}
