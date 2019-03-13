#ifndef RAWTABLE_H
#define RAWTABLE_H

#include <QHash>

#include <rawitem.h>

class RawTable
{
public:
    RawTable();
    void InsertRawItem(uint timestamp, RawItem *);
    QHash<uint, RawItem *>* GetRawItems();
private:
    QHash<uint, RawItem *> rawitems_;
};

#endif // RAWTABLE_H
