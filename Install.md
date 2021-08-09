# macOS Install 2020 Q2

## Install Xcode Devtools

```sh
xcode-select --install
```

<br>

## Install Homebrew

Install the Homebrew package manager. This will allow you to install almost any app from the command line.

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Make sure everything is up to date.

```sh
brew update
```

<br>

## Node.js

Use [Node Version Manager (nvm)](https://github.com/nvm-sh/nvm/blob/master/README.md#install--update-script) to install Node.js. This allows you to easily switch between Node versions, which is essential.

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
```

Install the latest version.

```sh
nvm install node
```

Restart terminal and run the final command.

```sh
nvm use node
```

Confirm that you are using the latest version of Node and npm.

```sh
node -v
npm -v
```

## Install Software with Brew

```
brew install curl git-ftp make mas webp youtube-dl
```

Optional

```sh
brew install coreutils gcal postgresql@10 rbenv redis-cli starship themekit tmux travis wget
```

<br>

## Install Software with Cask

```sh
brew cask alfred
brew cask appcleaner
brew cask ccleaner
brew cask contraste
brew cask cyberduck
brew cask dropbox
brew cask duet
brew cask endurance
brew cask figma
brew cask firefox
brew cask google-chrome
brew cask google-trends
brew cask hyper
brew cask imageoptim
brew cask install 1password
brew cask iterm2
brew cask kindle
brew cask macdown
brew cask mamp
brew cask numi
brew cask postman
brew cask runjs
brew cask sequel-pro
brew cask slack
brew cask smcfancontrol
brew cask spotify
brew cask sublime-text
brew cask telegram
brew cask transmission
brew cask vanilla
brew cask visual-studio-code
brew cask vlc
brew cask zeplin
brew cask zoomus
```

Optional:

```sh
brew cask 1password-cli dbeaver-community dbngin docker docker-toolbox flux grammarly image2icon krisp psequel qlmarkdown quicklook-json rectangle tinypng4mac tripmode typora
```

<br>

## Mac App Store [MAS]

```sh
mas install 918858936 # airmail-3       https://itunes.apple.com/mx/app/airmail-3/id918858936
mas install 417375580 # bettersnaptool  https://itunes.apple.com/mx/app/bettersnaptool/id417375580
mas install 409183694 # keynote         https://itunes.apple.com/mx/app/keynote/id409183694
mas install 409201541 # pages           https://itunes.apple.com/mx/app/pages/id409201541
mas install 409203825 # numbers         https://itunes.apple.com/mx/app/numbers/id409203825
mas install 967805235 # paste           https://itunes.apple.com/mx/app/paste-smart-clipboard-history/id967805235
mas install 928871589 # noizio          https://itunes.apple.com/mx/app/noizio/id928871589
mas install 425424353 # the-unarchiver  https://itunes.apple.com/mx/app/the-unarchiver/id425424353
mas install 494803304 # wifi-explorer   https://itunes.apple.com/mx/app/wifi-explorer/id494803304
```

<br>

## Other Software

- AirBuddy [GET](https://gumroad.com/library)
- Color Picker [GET](http://www.northernspysoftware.com/software/colorpicker)
- Hemingway [GET](https://gumroad.com/library)
- Netspot
- OverSight [GET](https://objective-see.com/products/oversight.html)
- Port Manager [GET](https://gumroad.com/library)
- Sonos [GET](https://www.sonos.com/redir/controller_software_mac)

<br>

## Terminal Setup

> Source: [HowTo: My Terminal & Shell setup - Hyper.js + ZSH + starship](https://tjay.dev/howto-my-terminal-shell-setup-hyper-js-zsh-starship/)

### Install FiraCode

Download the latest version of the font from Github releases tab:

- [GitHub](https://github.com/tonsky/FiraCode/releases)
- [Current](https://github.com/tonsky/FiraCode/releases/download/3/FiraCode_3.zip)

Now, when our font is installed let’s set it in our Hyper terminal:

We need to install a dedicated plugin: hyper-font-ligatures:

```sh
hyper i hyper-font-ligatures
```

### Theme

```sh
hyper i hyper-one-dark
```

### Plugins

```sh
hyper i hyper-search
hyper i hyper-pane
hyper i hypercwd
hyper i hyper-active-tab
```

### Shell - ZSH + starship prompt

```sh
brew install zsh
brew install starship
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

mkdir ~/.zsh

cd ~/.zsh && git clone git@github.com:zdharma/fast-syntax-highlighting.git
https://github.com/zdharma/fast-syntax-highlighting.git
echo "source $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" >> ~/.zshrc


cd ~/.zsh && wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/completion.zsh
echo "source $HOME/.zsh/completion.zsh" >> ~/.zshrc


cd ~/.zsh && git clone git@github.com:zsh-users/zsh-autosuggestions.git
echo "source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

cd ~/.zsh && wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/history.zsh
echo "source $HOME/.zsh/history.zsh" >> ~/.zshrc

source ~/.zshrc
```

### ZSH, Aliases and Hyper Config Files

```sh
open https://gist.github.com/chepetime/0f91dd8c6467dabaa3703082573dc10f#file-zshrc
code ~/.zshrc

https://gist.github.com/chepetime/0f91dd8c6467dabaa3703082573dc10f#file-aliases-zsh
touch ~/.zsh/aliases.zsh
code ~/.zsh/aliases.zsh

open https://gist.github.com/chepetime/0f91dd8c6467dabaa3703082573dc10f#file-hyper-js
code ~/.hyper.js
```

<br>

## Install PowerFonts

<br>

## Write Defaults

> [Source](https://gist.github.com/chepetime/eb94d1ad56212f2fcc99c1d924c26224)

```sh
open https://gist.github.com/chepetime/0f91dd8c6467dabaa3703082573dc10f#file-write-defaults-sh
```

## Git

The first thing you should do with Git is set your global configuration.

```sh
touch ~/.gitconfig
git config --global user.name "Your Name Here"
git config --global user.email "your_email@youremail.com"
code ~/.gitconfig
git config --global credential.helper osxkeychain
```

Input your config and create some aliases.

```sh
[user]
  name   = Firstname Lastname
  email  = you@example.com
[github]
  user   = username
[alias]
  a      = add
  ca     = commit -a
  cam    = commit -am
  cm     = commit -m
  s      = status
  pom    = push origin master
  pog    = push origin gh-pages
  puom   = pull origin master
  puog   = pull origin gh-pages
  cob    = checkout -b
  co     = checkout
  fp     = fetch --prune --all
  l      = log --oneline --decorate --graph
  lall   = log --oneline --decorate --graph --all
  ls     = log --oneline --decorate --graph --stat
  lt     = log --graph --decorate --pretty=format:'%C(yellow)%h%Creset%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)%an%Creset'
```

With the above aliases, I can run `git s` instead of `git status`, for example. The less I have to type, the happier I am.

## SSH

Simplify the process of SSHing into other boxes. Create an SSH config file.

```sh
mkdir ~/.ssh && touch ~/.ssh/config
code .ssh/config
```

Add the following contents, changing the variables for any hosts that you connect to. Using the below will be the same as running `ssh -i ~/.ssh/key.pem user@example.com`.

```
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa

Host myssh
  HostName example.com
  User user
  IdentityFile ~/.ssh/key.pem
```

Now just run the alias to connect.

```sh
ssh myssh
```

## Generate SSH key

You can [generate an SSH key](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) to distribute.

```
ssh-keygen -t rsa -b 4096 -C "chepe.time@gmail.com"
```

Add key.

```
ssh-add -K ~/.ssh/id_rsa
```

<br><br>

Sources:

- [macOS Catalina 10.15: Setting up a Brand New Mac for Development](https://www.taniarascia.com/setting-up-a-brand-new-mac-for-development/?ref=heydesigner)
- [macOS Setup Guide](http://sourabhbajaj.com/mac-setup/)

## <br> <br>

<br> <br>
