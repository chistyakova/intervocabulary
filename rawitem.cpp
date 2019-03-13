#include "rawitem.h"

RawItem::RawItem(QVariant variant) {
    variant_ = variant;
    comment_ = nullptr;
}

QVariant* RawItem::GetVariant() {
    return &variant_;
}
