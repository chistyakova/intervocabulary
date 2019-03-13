#ifndef HELPERS_H
#define HELPERS_H

#include <QString>

namespace helpers {

inline QString IntToString(int n, int len)
{
    QString result(len--, '0');
    for (int val=(n<0)?-n:n; len>=0&&val!=0; --len,val/=10)
       result[len]='0'+val%10;
    if (len>=0&&n<0) result[0]='-';
    return result;
}

}

#endif // HELPERS_H
