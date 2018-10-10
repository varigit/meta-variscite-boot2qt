/****************************************************************************
**
** Copyright (C) 2018 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Boot to Qt meta layer.
**
** $QT_BEGIN_LICENSE:GPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

var targetHost = "Linux";
var currentHost = "Linux";

function Component()
{
    if ("@SDKFILE@".indexOf("mingw32") >= 0)
        targetHost = "Windows";

    if (systemInfo.kernelType === "winnt")
        currentHost = "Windows";
    else if (systemInfo.kernelType === "darwin")
        currentHost = "macOS";

    if (currentHost != targetHost) {
        component.enabled = false;
        component.setValue("Default", false);
        installer.componentByName(component.name + ".toolchain").setValue("Default", false);
        installer.componentByName(component.name + ".toolchain").enabled = false;
        installer.componentByName(component.name + ".system").setValue("Default", false);
        installer.componentByName(component.name + ".system").enabled = false;

        gui.currentPageWidget().completeChanged.connect(this, Component.prototype.completeChanged)
    }
}

Component.prototype.completeChanged = function ()
{
    QMessageBox.critical("error", "Invalid QBSP package", "The selected QBSP supports only " + targetHost + " host platform.\nPlease restart the installer before continuing.");
}
