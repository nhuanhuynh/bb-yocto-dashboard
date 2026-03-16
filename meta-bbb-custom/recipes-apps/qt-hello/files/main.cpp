#include <QApplication>
#include <QLabel>
#include <QWidget>

int main(int argc, char *argv[])
{
    qputenv("QT_QPA_FONTDIR", "/usr/share/fonts/truetype");

    QApplication app(argc, argv);

    QWidget window;
    window.setStyleSheet("background-color: #1a1a2e;");
    window.resize(320, 240);

    QLabel label(&window);
    label.setText("Hello BBB!");
    label.setStyleSheet("color: #00aaff; font-size: 24px; font-weight: bold;");
    label.setAlignment(Qt::AlignCenter);
    label.resize(320, 240);

    window.show();
    return app.exec();
}
