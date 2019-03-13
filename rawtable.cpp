#include "rawtable.h"

RawTable::RawTable() {
}

void RawTable::InsertRawItem(uint timestamp, RawItem *rawitem) {
    rawitems_.insert(timestamp, rawitem);
}

QHash<uint, RawItem *>* RawTable::GetRawItems() {
    return &rawitems_;
}
