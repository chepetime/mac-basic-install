## Start staks
echo Start

## Install devtools
xcode-select --install

## Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## Install CLI tools
# yarn  https://github.com/yarnpkg/yarn
# mas   https://github.com/mas-cli/mas
brew install yarn mas zsh zsh-completions zsh-syntax-highlighting

## Set default shell to zsh
chsh -s $(which zsh)

## Install Oh My zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

## Install Apps via Cask | https://caskroom.github.io/search
# brew cask install adobe-creative-cloud-cleaner-tool
brew cask install adobe-acrobat
# brew cask install adobe-after-effects-cc adobe-illustrator-cc
# brew cask install adobe-photoshop-cc adobe-photoshop-lightroom adobe-premiere-pro-cc
brew cask install aerial alfred appcleaner caffeine cake ccleaner cleanmymac colorpicker dash dropbox endurance fantastical firefox
brew cask install google-chrome image2icon imageoptim mamp marp p5 postman raindropio sketch sketch-toolbox
brew cask install skyfonts slack smcfancontrol spotify steam sublime-text transmit transmission tripmode typora
brew cask install virtualbox virtualbox-extension-pack vlc zeplin

## Signin to Mac App Store | https://github.com/mas-cli/mas
mas signin yourmail@here.com

## Install Mac Store apps by ID
mas install 425424353 409201541 409183694 409203825 417375580 918858936 967805235 494803304 1054607607 1041381991 1028838684 928871589 972572731

# airmail-3       https://itunes.apple.com/mx/app/airmail-3/id918858936
# keynote         https://itunes.apple.com/mx/app/keynote/id409183694
# numbers         https://itunes.apple.com/mx/app/numbers/id409203825
# pages           https://itunes.apple.com/mx/app/pages/id409201541
# paste           https://itunes.apple.com/mx/app/paste-smart-clipboard-history/id967805235
# artpaper        https://itunes.apple.com/mx/app/artpaper-art-paintings-as/id1028838684
# beautiful-earth https://itunes.apple.com/mx/app/beautiful-earth-1-500+-earth/id1041381991
# bettersnaptool  https://itunes.apple.com/mx/app/bettersnaptool/id417375580
# helium          https://itunes.apple.com/mx/app/helium/id1054607607
# instashare      https://itunes.apple.com/mx/app/instashare-transfer-files/id685953216
# money-pro       https://itunes.apple.com/mx/app/money-pro-finanzas-personales/id972572731
# noizio          https://itunes.apple.com/mx/app/noizio/id928871589
# the-unarchiver  https://itunes.apple.com/mx/app/the-unarchiver/id425424353
# wifi-explorer   https://itunes.apple.com/mx/app/wifi-explorer/id494803304

## Set iTerm theme
# echo ZSH_THEME="agnoster" >> ~/.zshrc

## Sync Sublime Text 3 | https://packagecontrol.io/docs/syncing#dropbox-osx
# cd ~/Library/Application Support/Sublime Text 3/Packages
# rm -r User
# ls -s ~/Dropbox/Sublime/User/

## Add Sublime Text 3 to the command line
sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

## Configuring Git
git config --global color.ui true
git config --global user.name "José Lugo"
git config --global user.email "chepe.time@gail.com"

# Copy SSH Key
## pbcopy < ~/.ssh/id_rsa.pub

## End tasks
echo Ends
