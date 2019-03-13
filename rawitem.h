#ifndef RAWITEM_H
#define RAWITEM_H

#include <QVariant>
#include <QString>

class RawItem
{
public:
    RawItem(QVariant variant);
    QVariant* GetVariant();
private:
    QVariant variant_;
    QString* comment_;
};

#endif // RAWITEM_H
