#ifndef VOCUBSMODEL_H
#define VOCUBSMODEL_H

#include <QAbstractListModel>

#include "vocub.h"

class VocubsModel : public QAbstractListModel
{
    Q_OBJECT

public:
    Q_INVOKABLE QVariantMap get(int index);
    VocubsModel(QVector<Vocub> *vocabs, QObject *parent = nullptr);
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    enum Roles {
      flag = Qt::UserRole + 1,
      title,
      description
    };
    virtual QHash<int, QByteArray> roleNames() const;
    virtual QVariant data(const QModelIndex &index, int role) const;

    void notifyChange();
private:
    QVector<Vocub> *vocubs_;
};

#endif // VOCUBSMODEL_H
