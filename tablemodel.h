#ifndef TABLEMODEL_H
#define TABLEMODEL_H

#include <QObject>
#include <QAbstractListModel>

#include <QAbstractListModel>
#include <QStringList>

#include <QVariantList>

#include "rawtable.h"

class TableModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        YearRole = Qt::UserRole + 1,
        MonthRole,
        DayRole,
        HourRole,
        MinuteRole,
        ValueRole
    };

    TableModel(QStringList *,
               QVector<QVector<QVector<QVariant> > >*,
               QObject *parent = 0);

    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE void add(const int);
    Q_INVOKABLE void change(const int, const QString);

    void Feed(const QVector<QVariant> *);
private:
    QList<QStringList> t;
    //QList<QStringList>* table_;

    QVector<uint> timestamps_;
    QList<RawTable *> rawtables_;

    QStringList *settings_;
    QVector<QVector<QVector<QVariant> > > *tables_;
};

#endif // TABLEMODEL_H
