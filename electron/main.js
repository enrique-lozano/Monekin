const { app, BrowserWindow } = require("electron");

const url = require("url");
const path = require("path");

// TODO: Improve the design of the title bar. Maybe following this great repo https://github.com/binaryfunt/electron-seamless-titlebar-tutorial

function onReady() {
  var win = new BrowserWindow({
    width: 1024,
    height: 728,
    minWidth: 300,
    icon: "./src/assets/resources/appIcon.png",
  });

  win.loadURL(
    url.format({
      pathname: path.join(__dirname, "./../www/index.html"),
      protocol: "file:",
      slashes: true,
    })
  );

  win.maximize(); // Full screen window

  if (app.isPackaged) {
    win.webContents.openDevTools();
  }

  win.setMenu(null);
}

app.on("ready", onReady);
