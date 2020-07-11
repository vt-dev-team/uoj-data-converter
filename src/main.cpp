#include <QApplication>
#include <QCommandLineParser>

#include "MainWindow.hpp"
#include "TestCaseChoosePage.hpp"
#include "generated/version.hpp"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QCoreApplication::setApplicationName("UOJ Data Converter");
    QCoreApplication::setApplicationVersion(DISPLAY_VERSION);

    QCommandLineParser parser;
    parser.setApplicationDescription("将各种各样格式的数据转换为 UOJ 的格式。");
    parser.addHelpOption();
    parser.addVersionOption();

    parser.process(app);

    MainWindow mainWindow;

    mainWindow.show();

    return app.exec();
}