#ifndef ARSAPIURL_H
#define ARSAPIURL_H

#include <QUrl>

class ArsApiUrl : public QUrl {
    static const QString apiPrefix;

public:
    static const QString address;

    ArsApiUrl();

    ArsApiUrl(const QString &url);

    ArsApiUrl(const QString &url, QList<QPair<QString, QString>> parameters);
};

#endif // ARSAPIURL_H
