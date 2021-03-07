# Setting up a brand new mac for Web Development

> 🖥 Got a new Mac or a fresh macOS? 🍎 Use this tools to get everything you need!

I have been using macOS for Web Development 10 years now, and from time to time I have to set up new machines for this.

This article goes back to 2015 when I got my first professional developer job and have been updating it ever since with whatever my stack evolves.

I'm primarily a full-stack web developer, so most of my needs will revolve around JavaScript/Node.js.

## Getting Started

The setup assistant will launch once you turn the computer on. Enter your language, time zone, Apple ID, and so on. The first thing you should do is update macOS to get the latest security updates and patches.

### Update Your Mac

Before installing any new software, follow these instructions from Apple to upgrade macOS and your current software to the latest version.

### Command Line Developer Tools

The first thing you’ll need to install from the command line are the Command Line developer Tools. Install the tools with this command:

```sh
xcode-select --install
```

<br/>

## Homebrew

Install the Homebrew package manager. This will allow you to install almost any app from the command line.

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Make sure everything is up to date.

```sh
brew update
```

<br/>

## Install Apps

Here are some the programs I always install.

> Don't install Node.js through Homebrew. Use nvm (below).

```sh
brew install --cask 1password \
alfred \
appcleaner \
contraste \
cyberduck \
dropbox \
figma \
google-chrome \
hyper \
imageoptim \
kap \
kindle \
macdown \
macs-fan-control \
numi \
plug \
postman \
responsively \
runjs \
sequel-pro \
sketch \
skyfonts \
slack \
spark \
spotify \
sublime-text \
telegram \
the-unarchiver \
visual-studio-code \
transmission \
vlc \
whatsapp \
zeplin \
zettlr \
drawio \
zoom
```

znstall other CLI utilities:

```sh
brew install youtube-dl awscli ffmpeg wget
```

<br/>

## Install Apps from the AppStore

We can use [mas-cli](https://github.com/mas-cli/mas) to install apps from the Mac App Store using the ID. Before installing the tool you need to log to the App Store using your email.

Install the tool:

```sh
brew install mas
```

Install Mac Store apps by ID:

```sh
mas install 409183694 409203825 409201541 967805235 417375580 928871589 494803304
```

Common Apps:

| App            | Id        | Url                                                                       |
| -------------- | --------- | ------------------------------------------------------------------------- |
| keynote        | 409183694 | https://itunes.apple.com/mx/app/keynote/id409183694                       |
| numbers        | 409203825 | https://itunes.apple.com/mx/app/numbers/id409203825                       |
| pages          | 409201541 | https://itunes.apple.com/mx/app/pages/id409201541                         |
| paste          | 967805235 | https://itunes.apple.com/mx/app/paste-smart-clipboard-history/id967805235 |
| bettersnaptool | 417375580 | https://itunes.apple.com/mx/app/bettersnaptool/id417375580                |
| noizio         | 928871589 | https://itunes.apple.com/mx/app/noizio/id928871589                        |
| wifi-explorer  | 494803304 | https://itunes.apple.com/mx/app/wifi-explorer/id494803304                 |

<br/>

## Install other app from their website

```sh
open https://colormate.io
open https://dropoverapp.com
open https://fireball.studio/moment
open https://fireball.studio/oneswitch
open https://macpaw.com/encrypto
open https://poolside.fm
open https://portmanager.app
open https://sindresorhus.com/jiffy
open https://sindresorhus.com/shareful
open https://support.sonos.com/s/downloads?language=es
open https://swach.io
open https://trymeeter.com
open https://adobe.com/mx/products/xd.html
open https://logitech.com/es-mx/product/options
open https://utsire.com/touch-bar-piano
```

<br/>

## Shell

Newer versions of macOs come with zsh as the default shell. We will install starship and some utilities.

### Shell Font: FireCode

[Download FiraCode](https://github.com/tonsky/FiraCode)

### Shell Terminal: Hyper.js

Install Hyper:

```sh
brew install hyper
```

Modify `~/.hyper.js`:

```json
{
  //...
  "fontFamily": "\"Fira Code\", Menlo, \"DejaVu Sans Mono\", Consolas, \"Lucida Console\", monospace",

  //...
  "shell": "/bin/zsh",

  //...
  "plugins": [
    "hyper-font-ligatures",
    "hyper-pane",
    "hypercwd",
    "hyper-material-theme"
  ]
}
```

### Shell Prompt: Starship

There are a few different ways to install starship described in the documentation:

> [GitHub - starship/starship: ☄️🌌️ The cross-shell prompt for astronauts.](https://github.com/starship/starship#-installation)

Install Starship:

```sh
brew install starship
```

Check whether it’s working:

```sh
❯ starship --version
starship 0.50.0
```

To enable starship prompt we need to add it to `~/.zshrc`. Add following code to the end of `~/.zshrc` file:

```sh
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
```

### Shell Extras: Plugins

#### Setup

```sh
# Create a `.zsh` directory to store our plugins in one place
mkdir ~/.zsh
```

### Plugin: Syntax Highlighting

```sh
# Clone repo to `~/.zsh/` directory
cd ~/.zsh && git clone git@github.com:zdharma/fast-syntax-highlighting.git

# Enable 'fast-syntax-highlighting' plugin in ZSH
echo "source $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" >> ~/.zshrc

# Reload ZSH
source ~/.zshrc
```

### Plugin: Completion

```sh
# Download completion config
cd ~/.zsh && wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/completion.zsh

# Enable 'completion' plugin in ZSH
echo "source $HOME/.zsh/completion.zsh" >> ~/.zshrc
```

Then modify the .zshrc file:

```sh
nano ~/.zshrc
```

```sh
# ~/.zshrc

source ~/.zsh/completion.zsh

# Initialize the completion system
autoload -Uz compinit

# Cache completion if nothing changed - faster startup time
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi
```

### Plugin: Autosuggestions

```sh
# Download completion config
cd ~/.zsh && git clone https://github.com/zsh-users/zsh-autosuggestions

# Enable 'completion' plugin in ZSH
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
```

### Plugin: History

```sh
# Download history config
cd ~/.zsh && wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/history.zsh

# Enable 'history' config in ZSH
echo "source $HOME/.zsh/history.zsh" >> ~/.zshrc
```

<br/>

## Node.js

Use Node Version Manager (nvm) to install Node.js. This allows you to easily switch between Node versions, which is essential.

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
```

### Install

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
node -v && npm -v
```

### Update

For later, here's how to update nvm.

```sh
nvm install node --reinstall-packages-from=node
```

### Change version

Here's how to switch to another version and use it.

```sh
nvm install xx.xx
nvm use xx.xx
```

And to set the default:

```sh
nvm alias default xx.xx
```

<br/>

## Git

The first thing you should do with Git is set your global configuration.

```sh
touch ~/.gitconfig
```

Input your config and create some aliases.

```
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

With the above aliases, I can run git s instead of git status, for example. The less I have to type, the happier I am.

<br/>

## Defaults

```sh
# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
```
<br/>

<br/>

## References, Inspiration and main workload by:

- https://www.taniarascia.com/setting-up-a-brand-new-mac-for-development/
- https://tjay.dev/howto-my-terminal-shell-setup-hyper-js-zsh-starship/
- https://www.freecodecamp.org/news/how-to-set-up-a-brand-new-macbook/


<br/>
<br/>

---

Made with ❤️ by [chepetime](https://github.com/chepetime) @ Mexico City
