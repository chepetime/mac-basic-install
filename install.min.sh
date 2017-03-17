## Start

xcode-select --install

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install yarn mas zsh zsh-completions zsh-syntax-highlighting

chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew cask install adobe-acrobat aerial alfred appcleaner caffeine cake ccleaner cleanmymac colorpicker dash dropbox endurance fantastical firefox google-chrome image2icon imageoptim mamp marp p5 postman raindropio sketch sketch-toolbox skyfonts slack smcfancontrol spotify steam sublime-text transmit transmission tripmode typora virtualbox virtualbox-extension-pack vlc zeplin

mas signin yourmail@here.com

mas install 425424353 409201541 409183694 409203825 417375580 918858936 967805235 494803304 1054607607 1041381991 1028838684 928871589 972572731

echo ZSH_THEME="agnoster" >> ~/.zshrc

cd ~/Library/Application Support/Sublime Text 3/Packages
rm -r User
ls -s ~/Dropbox/Sublime/User/

sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

git config --global color.ui true
git config --global user.name "Yourname"
git config --global user.email "yourmail@here.com"

pbcopy < ~/.ssh/id_rsa.pub