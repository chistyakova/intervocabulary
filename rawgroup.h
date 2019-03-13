#ifndef RAWGROUP_H
#define RAWGROUP_H

#include <QString>
#include <QVector>

#include <rawitem.h>

class RawGroup
{
public:
    void SetName(QString name){name_ = name;}
    QString* GetName(){return &name_;}

    void SetDescription(QString description){description_ = description;}
    QString* GetDescripton(){return &description_;}

    void SetImage(QString image){image_ = image;}
    QString* GetImage(){return &image_;}

    void SetScale(uint scale){scale = scale;}
    uint GetScale(){return scale_;}

    void AppendTableId(uint id){table_order_.append(id);}
    QVector<uint>* GetTableOrder(){return &table_order_;}
protected:
    QString name_;
    QString description_;
    QString image_;
    uint scale_;
    QVector<uint> table_order_;
};

#endif // RAWGROUP_H
