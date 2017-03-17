# Mac Basic Install

> 🖥 Got a new Mac or a fresh macOS? 🍎 Use this tools to get everything you need!

## 🎈 Preparation

1. Get the latest version of [Node.Js from the official site][1].
2. Sign In into the Mac App Store. (Only needed if you want to install Apps from the store)

## 💻 Use

Included in this repository, there's a file called ```install.sh```. A full setup for using automating Mac Applications installation can be found there. Run it or copy the commands into a terminal.

> Customize the file to meet your needs. Some lines in the are commented for documentation or for further configuration. Consider the current file as a **WIP**.

## 🔧 Customize install file

To tailor the installation file you can add more Mac Applications using **Homebrew**, **Cask** and **MAS**.

### Homebrew

> 🍰 Homebrew is a Package manager for macOS.
> <br> [Site and documentation][10]

To install a new package run:

```sh
brew install [package-name]
brew install yarn
```

[Search for more avaliable Mac applications with Homebrew][11]

### Cask

> 🌰 A CLI workflow for the administration of Mac applications distributed as binaries.
> <br> [Site and documentation][20]

Cask extends Brew to install Mac Application Binaries. To install a new package run:

```sh
brew cask install [package-name]
brew cask install dropbox
brew cask install google-chrome firefox
```

[Search for more avaliable Mac applications with Cask][21]

### Mac App Store command line interface (MAS)

> 📦 Mac App Store command line interface.
> <br> [Site and documentation][30]

Before using MAS you might need to login into the Mac App Store, and then into MAS with:

```sh
mas signin yourMacAppStorEmail@here.com
```

To install a new Mac Application, you need to get the App's Id.
You can easily get it by looking into it's url:

- **numbers** ```https://itunes.apple.com/mx/app/numbers/id409203825```
- **pages**   ```https://itunes.apple.com/mx/app/pages/id409201541```
- **keynote** ```https://itunes.apple.com/mx/app/keynote/id409183694```

To install, just run:

```sh
mas install [package-id]
mas install 409203825 409201541 409183694
```

## 🗃 Default setup
> The default ```install.sh``` includes my day-to-day and favorite Mac Applications.

- Xcode Tools
- Homebrew
- Mac App Store command line interface
- zsh
  - zsh-completions
  - zsh-syntax-highlighting
  - Oh My zsh
- Adobe Acrobat
- Adobe Creative Cloud Cleaner Tool
- Aerial
- Airmail 3
- Alfred
- Appcleaner
- Artpaper
- Beautiful Earth
- Caffeine
- Cake
- Ccleaner
- Cleanmymac
- Colorpicker
- Dash
- Dropbox
- Endurance
- Fantastical
- Firefox
- Google-chrome
- Image2icon
- Imageoptim
- Instashare
- Mamp
- Marp
- Money Pro
- P5.js
- Paste
- Postman
- Raindropio
- Sketch and Sketch Toolbox
- Skyfonts
- Slack
- Smcfancontrol
- Spotify
- Steam
- Sublime-text
- The Unarchiver
- Transmit
- transmission
- Tripmode
- Typora
- Virtualbox and Virtualbox Extension Pack
- VLC
- Wifi Explorer
- Zeplin

---

[1]:https://nodejs.org/en/
[10]:https://brew.sh
[11]:http://braumeister.org/
[20]:https://caskroom.github.io/
[21]:https://caskroom.github.io/search
[30]:https://github.com/mas-cli/mas

Made with ❤️ by [chepetime](https://github.com/chepetime) @ Mexico City