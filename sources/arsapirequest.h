#ifndef ARSAPIREQUEST_H
#define ARSAPIREQUEST_H

#include <QNetworkRequest>

class ArsApiRequest : public QNetworkRequest {
public:
    ArsApiRequest();
    ArsApiRequest(QString acction);
    static QByteArray toJsonBody(QMap<QString, QString> body);
};

#endif // ARSAPIREQUEST_H
