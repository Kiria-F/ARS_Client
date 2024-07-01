#include "arsapiurl.h"
#include <QLibraryInfo>
#include <QStringBuilder>

const QString ArsApiUrl::address = QLibraryInfo::isDebugBuild() ? "http://localhost:5057"
                                                                : "https://allrensys.com";
const QString ArsApiUrl::apiPrefix = address + "/api/";

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
