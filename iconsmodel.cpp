#include "iconsmodel.h"

#include <QDir>

IconsModel::IconsModel(QObject *parent):
    QAbstractListModel(parent)
{

}

int IconsModel::rowCount(const QModelIndex &parent) const
{
    return 1;
}

QVariant IconsModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }
    return QVariant();
}

QStringList IconsModel::getIcons()
{
    QDir dir("/icons");
    QFileInfoList list = dir.entryInfoList();
    QStringList iconList;
    for (int i = 0; i < list.size(); ++i) {
        QFileInfo fileInfo = list.at(i);
        iconList.push_back(fileInfo.fileName());
    }
    return iconList;
}
