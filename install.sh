sudo apt install -y git curl
sudo apt install -y zsh
sudo snap install --classic nvim
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sudo cp -r ./dotfiles/.config/i3 ~/.config/i3/
sudo cp -r ./dotfiles/.config/nvim ~/.config/nvim/
sudo cp -r ./dotfiles/.config/tmux ~/.config/tmux/
sudo cp -r ./dotfiles/.config/kitty ~/.config/kitty/
