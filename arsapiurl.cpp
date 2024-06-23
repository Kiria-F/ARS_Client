#include "arsapiurl.h"
#include "QStringBuilder"

const QString ArsApiUrl::apiPrefix = "https://allrensys.com/api/";

ArsApiUrl::ArsApiUrl() : QUrl() {}

ArsApiUrl::ArsApiUrl(const QString &url) : QUrl(apiPrefix + url) {}

ArsApiUrl::ArsApiUrl(const QString &url,
                     QList<QPair<QString, QString>> parameters)
    : QUrl(apiPrefix % url % "?" % [&parameters](){
        QStringList qsl;
        for (auto parameter : parameters) {
            qsl.append(parameter.first % "=" % parameter.second);
        }
        return qsl.join("&");
    }()) {}
