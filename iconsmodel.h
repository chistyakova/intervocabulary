#ifndef ICONSMODEL_H
#define ICONSMODEL_H

#include <QAbstractListModel>
#include <QObject>
#include <QStringList>
#include <QVariant>

class IconsModel : public QAbstractListModel
{
    Q_OBJECT

public:
    IconsModel(QObject *parent = 0);

    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;

    QStringList getIcons();
};

#endif // ICONSMODEL_H
