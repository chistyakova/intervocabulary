#include "tablemodel.h"
#include "helpers.h"

#include <QDebug>
#include <QDateTime>

TableModel::TableModel(QStringList *settings,
                       QVector<QVector<QVector<QVariant> > > *tables,
                       QObject *parent):
    QAbstractListModel(parent) {
    settings_ = settings;
    tables_ = tables;
}

int TableModel::rowCount(const QModelIndex &parent) const {
    if (parent.isValid()) {
        return 0;
    }
    //return timestamps_.count();
    return 0;//tables_->at(0).size();
}

QVariant TableModel::data(const QModelIndex &index, int role) const{
    if (!index.isValid()) {
        return QVariant();
    }
    const QVector<QVector<QVariant> >* table = &tables_->at(0);
    QDateTime timestamp = table->at(index.row()).at(0).toDateTime();
    switch (role) {
        case YearRole:  return QString::number(timestamp.date().year());
        case MonthRole: return QString::number(timestamp.date().month());
        case DayRole:   return QString::number(timestamp.date().day());
        case HourRole:  return QString::number(timestamp.time().hour());
        case MinuteRole:return QString::number(timestamp.time().minute());
        case ValueRole: {
            QStringList value;
            for (int i = 1; i < table->at(index.row()).count(); ++i) {
                value.append(table->at(index.row()).at(i).toString());
            }
//                RawTable* rawtable = rawtables_.at(i);

//                QHash<uint, RawItem *>* rawitems = rawtable->GetRawItems();
//                QHash<uint, RawItem *>::iterator it = rawitems->find(
//                            timestamp);
//                if (it != rawitems->end())
//                    value.append(it.value()->GetVariant()->toString());
//                else
//                    value.append("");
//            }
//            return value;
              return value;
        }
        default:
            return QVariant();
    }
}

QHash<int, QByteArray> TableModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[YearRole] = "year";
    roles[MonthRole] = "month";
    roles[DayRole] = "day";
    roles[HourRole] = "hour";
    roles[MinuteRole] = "minute";
    roles[ValueRole] = "value";
    return roles;
}

void TableModel::add(const int index)
{
//    beginInsertRows(QModelIndex(), m_data->size(), m_data->size());
//    m_data->append("new");
//    endInsertRows();

//    m_data[0] = QString("Size: %1").arg(m_data->size());
//    QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
//    emit dataChanged(index, index);
}

void TableModel::change(const int index, const QString value)
{
    //QStringList row = table_->at(index);
    //row.replace(0, value);
    //table_->replace(index, row);
    //QModelIndex i = createIndex(index, row.size(), static_cast<void *>(0));
    //emit dataChanged(i, i);
}

void TableModel::Feed(const QVector<QVariant> *table)
{
    emit beginResetModel();
    //timestamps_ = timestamps;
    //rawtables_ = rawtables;
    emit endResetModel();
}
