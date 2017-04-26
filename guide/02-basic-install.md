# Basic Install

## Install Node.js

[Node.Js Official Site](https://nodejs.org/es/)

## Install devtools

```sh
xcode-select --install
```

## Install Homebrew

```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## Install CLI tools
- [yarn](https://github.com/yarnpkg/yarn)
- [mas](https://github.com/mas-cli/mas)

```sh
brew install yarn mas zsh zsh-completions zsh-syntax-highlighting
```

## Set default shell to zsh

```sh
chsh -s $(which zsh)
```

If the above doesn't work, try this:

```sh
chsh -s /usr/local/bin/zsh
```

## Install Oh My zsh

```sh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
```

### Install Pure

```sh
npm install --global pure-prompt
```

## Install Apps via Cask

[Search for more app](https://caskroom.github.io/search)

```sh
brew cask install adobe-creative-cloud-cleaner-tool
brew cask install adobe-acrobat
brew cask install adobe-after-effects-cc
brew cask install adobe-illustrator-cc
brew cask install adobe-photoshop-cc
brew cask install adobe-photoshop-lightroom
brew cask install adobe-premiere-pro-cc
brew cask install aerial
brew cask install alfred
brew cask install appcleaner
brew cask install caffeine
brew cask install cake
brew cask install ccleaner
brew cask install cleanmymac
brew cask install colorpicker
brew cask install dash
brew cask install dropbox
brew cask install endurance
brew cask install fantastical
brew cask install firefox
brew cask install google-chrome
brew cask install image2icon
brew cask install imageoptim
brew cask install mamp
brew cask install marp
brew cask install postman
brew cask install raindropio
brew cask install sketch
brew cask install sketch-toolbox
brew cask install skyfonts
brew cask install slack
brew cask install smcfancontrol
brew cask install spotify
brew cask install steam
brew cask install sublime-text
brew cask install transmission
brew cask install tripmode
brew cask install typora
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install vlc
brew cask install zeplin
```

In one command

```sh
brew cask install adobe-creative-cloud-cleaner-tool adobe-acrobat adobe-after-effects-cc adobe-illustrator-cc adobe-photoshop-cc adobe-photoshop-lightroom adobe-premiere-pro-cc aerial alfred appcleaner caffeine cake ccleaner cleanmymac colorpicker dash dropbox endurance fantastical firefox google-chrome image2icon imageoptim mamp marp postman raindropio sketch sketch-toolbox skyfonts slack smcfancontrol spotify steam sublime-text transmission tripmode typora virtualbox virtualbox-extension-pack vlc zeplin
```

## Install Mac Store apps

Sign in to Mac App Store using [MAS](https://github.com/mas-cli/mas)

```sh
mas signin yourmail@here.com
```

Install Mac Store apps by ID

- [airmail-3](https://itunes.apple.com/mx/app/airmail-3/id918858936)
- [keynote](https://itunes.apple.com/mx/app/keynote/id409183694)
- [numbers](https://itunes.apple.com/mx/app/numbers/id409203825)
- [pages](https://itunes.apple.com/mx/app/pages/id409201541)
- [paste](https://itunes.apple.com/mx/app/paste-smart-clipboard-history/id967805235)
- [artpaper](https://itunes.apple.com/mx/app/artpaper-art-paintings-as/id1028838684)
- [beautiful-earth](https://itunes.apple.com/mx/app/beautiful-earth-1-500+-earth/id1041381991)
- [bettersnaptool](https://itunes.apple.com/mx/app/bettersnaptool/id417375580)
- [helium](https://itunes.apple.com/mx/app/helium/id1054607607)
- [instashare](https://itunes.apple.com/mx/app/instashare-transfer-files/id685953216)
- [money-pro](https://itunes.apple.com/mx/app/money-pro-finanzas-personales/id972572731)
- [noizio](https://itunes.apple.com/mx/app/noizio/id928871589)
- [the-unarchiver](https://itunes.apple.com/mx/app/the-unarchiver/id425424353)
- [wifi-explorer](https://itunes.apple.com/mx/app/wifi-explorer/id494803304)

```sh
mas install 425424353 409201541 409183694 409203825 417375580 918858936 967805235 494803304 1054607607 1041381991 1028838684 928871589 972572731
```

## Sublime Text 3

[Dropbox Sync with Sublime](https://packagecontrol.io/docs/syncing#dropbox-osx)

```sh
cd ~/Library/Application Support/Sublime Text 3/Packages
rm -r User
ls -s ~/Dropbox/Sublime/User/
```

Add Sublime Text 3 to the command line

```sh
sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
```


## Configuring Git

```sh
git config --global color.ui true
git config --global user.name "Yourname"
git config --global user.email "yourmail@here.com"
```

## Generating a new SSH key

[Source](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)

Create a new SSH Key

```sh
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

Copy SSH Key

```sh
pbcopy < ~/.ssh/id_rsa.pub
```
