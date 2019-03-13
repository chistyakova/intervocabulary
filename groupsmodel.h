#ifndef MODEL_H
#define MODEL_H

#include <QAbstractListModel>
#include <QObject>
#include <QStringList>
#include <QVariantList>

#include "rawgroup.h"

class GroupsModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        NameRole = Qt::UserRole + 1,
        DescrptionRole,
        ImageRole,
        SplitNumberRole,
        ClickedRole
    };

    GroupsModel(QStringList *, QObject *parent = 0);//GroupsModel(QHash<uint, RawGroup*>*, QObject *parent = 0);

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE void add(const int);
    Q_INVOKABLE void change(const int, const QString);

    void reset();
    void clickTab(uint);
//signals:
  //  void dataChanged();
private:
    QHash<uint, RawGroup*>* rawgroups_;
    QVector<QPair<uint, uint> > pairs_rawgroup_split_number_;
    uint index_; // Порядковый номер выбранной группы

    QStringList permanentButtons_ = {"add.svg"};

    QStringList *settings_;
};

#endif // MODEL_H
